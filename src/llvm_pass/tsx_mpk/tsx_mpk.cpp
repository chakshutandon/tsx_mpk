#include <string>
#include <regex>

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
    struct TSX_MPK : public FunctionPass {
        static char ID;
        TSX_MPK() : FunctionPass(ID) {}

        const std::string LIB_UNSAFE_PREFIX = "__tsx_mpk_unsafe__.*";

        bool runOnFunction(Function &F) override {
            std::vector<Instruction*> set_delete;
            if (!std::regex_match(
                    F.getName().str(), 
                    std::regex(LIB_UNSAFE_PREFIX)
                )) {
                for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) {
                    if (!isa<CallInst>(*I)) continue;
                    Function *callee = cast<CallInst>(*I).getCalledFunction();
                    if (callee->getName() != "pkey_set") continue;
                    if (!I->use_empty()) I->replaceAllUsesWith(UndefValue::get(I->getType()));
                    set_delete.push_back(&*I);
                }
                for (auto i = set_delete.begin(); i != set_delete.end(); ++i) {
                    (*i)->eraseFromParent();
                }               
            }
            return true;
        }
    };
}

char TSX_MPK::ID = 0;
static RegisterPass<TSX_MPK> X("tsx_mpk", "Removes all dangerous pkey_set calls.", false, false);
