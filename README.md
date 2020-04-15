Here we are trying to solve a problem of semantic bugs in large programs while using locks on shared data structures

This is using Intel's MPK

To build LLVM:
git submodule init
git submodule update
1. cd llvm
2. mkdir build
3. cd build
4. cmake -G"Unix Makefiles" -DLLVM_ENABLE_PROJECTS="clang" -DLLVM_TARGETS_TO_BUILD=X86 ../llvm/
5. make -j 40
6. sudo make install
