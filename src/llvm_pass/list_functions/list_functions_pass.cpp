#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
    struct ListFunction : public FunctionPass {
        static char ID;
        ListFunction() : FunctionPass(ID) {}

        bool runOnFunction(Function &F) override {
            errs().write_escaped(F.getName()) << '\n';
            return false;
        }
    };
}

char ListFunction::ID = 0;
static RegisterPass<ListFunction> X("list_functions", "List Function Pass", false, false);