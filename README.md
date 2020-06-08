# tsx_mpk

This project introduces compile-time static analysis and a minimal runtime library
to enforce transactional semantics in large-scale systems.

Using Intel MPK (https://lwn.net/Articles/643797/), we are able to ensure there are
no data races due to shared memory structures. We warn users on potential data race
conditions and remove offending instructions from release binaries.

For more details, see the full paper (https://chakshutandon.com/research/tsx_mpk.pdf).

```
git clone https://gitlab.com/chakshutandon/tsx_mpk
cd tsx_mpk
make
```

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
