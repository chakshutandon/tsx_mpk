Here we are trying to solve a problem of semantic bugs in large programs while using locks on shared data structures

This is using Intel's MPK

How to use project:

1. Build ``lib_tsx_mpk.so`` (see lib/README.md)
2. Build example files in ./src (see src/README.md)

To build LLVM:

```
git submodule init
git submodule update

cd llvm
mkdir build
cd build
cmake -G"Unix Makefiles" -DLLVM_ENABLE_PROJECTS="clang" -DLLVM_TARGETS_TO_BUILD=X86 ../llvm/
make -j 40
sudo make install
```
