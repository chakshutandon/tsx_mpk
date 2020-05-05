#include <string>
#include <regex>

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InlineAsm.h"
#include "llvm/IR/Constants.h"

using namespace llvm;

namespace {
    struct TSX_MPK : public FunctionPass {
        static char ID;
        TSX_MPK() : FunctionPass(ID) {}

        const std::string LIB_UNSAFE_PREFIX = "__tsx_mpk_unsafe__.*";

        bool is_wrpkru(InlineAsm *inline_asm_inst) {
            std::string asm_string = inline_asm_inst->getAsmString();
            std::regex byte_code("(.|\n)*0x0f,0x01,0xef(.|\n)*", std::regex_constants::icase);
            std::regex x86_inst("(.|\n)*wrpkru(.|\n)*", std::regex_constants::icase);
            if (std::regex_match(asm_string, byte_code)) return true;
            if (std::regex_match(asm_string, x86_inst)) return true;
            return false;
        }

        bool runOnFunction(Function &func) override {
            std::vector<Instruction*> set_delete;

            // ignore functions with regular expression matching LIB_UNSAFE_PREFIX
            if (std::regex_match(func.getName().str(), std::regex(LIB_UNSAFE_PREFIX))) return false;

            // mark all instructions that touch PKRU
            // 1. WRPKRU
            // 2. pkey_set
            // 2. pkey_free
            // 3. pkey_mprotect (pkey != 1)
            for (inst_iterator I = inst_begin(func), E = inst_end(func); I != E; ++I) {
                Instruction& inst = *I;

                if (!isa<CallInst>(inst)) continue;
                CallInst& call_inst = cast<CallInst>(inst);
                
                // Using inline ASM e.g. WRPKRU
                if (call_inst.isInlineAsm()) {
                    Value *operand = call_inst.getCalledOperand();
                    InlineAsm *inline_asm = cast<InlineAsm>(operand);
                    if (is_wrpkru(inline_asm)) set_delete.push_back(&inst);
                    continue;
                }

                Function *callee = call_inst.getCalledFunction();
                std::string function_name = callee->getName();
                
                // Functions that modify PKRU
                if (function_name == "pkey_set") set_delete.push_back(&inst);
                if (function_name == "pkey_free") set_delete.push_back(&inst);
                if (function_name == "pkey_mprotect") {
                    ConstantInt *pkey = cast<ConstantInt>(call_inst.getOperand(3));
                    // pkey is non-negative
                    if (!pkey->isNegative()) set_delete.push_back(&inst);
                }
            }

            // notify and remove instructions marked in the previous loop
            for (auto inst : set_delete) {
                DebugLoc debug = inst->getDebugLoc();
                errs() << "WARNING: Removing offending instruction at ";
                debug.print(errs());
                errs() << ".\n";
                inst->eraseFromParent();
            }  
            return true;
        }
    };
}

char TSX_MPK::ID = 0;
static RegisterPass<TSX_MPK> X("tsx_mpk", "Removes all dangerous pkey_set calls.", false, false);
