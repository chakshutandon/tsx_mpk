#include <string>
#include <regex>

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
    struct TSX_MPK : public FunctionPass {
        static char ID;
        TSX_MPK() : FunctionPass(ID) {}

        const std::string LIB_UNSAFE_PREFIX = "__tsx_mpk_unsafe__.*";

        bool runOnFunction(Function &F) override {
            if (!std::regex_match(
                    F.getName().str(), 
                    std::regex(LIB_UNSAFE_PREFIX)
                )) {
                errs().write_escaped(F.getName()) << '\n';
            }
            return false;
        }
    };
}

char TSX_MPK::ID = 0;
static RegisterPass<TSX_MPK> X("tsx_mpk", "Removes all dangerous pkey_set calls.", false, false);
