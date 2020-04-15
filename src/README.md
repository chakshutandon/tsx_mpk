# SRC

Run ``list_functions`` pass on hello.c:

```
opt -load ./llvm_pass/build/list_fun
ctions/libListFunctionsPass.so -list_functions hello.ll > /dev/null
```

Create LLVM Intermediate Representation (IR):

```
clang -S -I../lib -emit-llvm with_lock.c -o with_lock.ll
clang -S -I../lib -emit-llvm without_lock.c -o without_lock.ll
opt -load ./llvm_pass/build/tsx_mpk/libTSX_MPK.so -tsx_mpk without_lock.ll > without_lock_llvm.bc
llc -filetype=obj without_lock_llvm.bc -o without_lock_llvm.o
```

Build:

```
gcc -o with_lock with_lock.c -I../lib ../build/lib/lib_tsx_mpk.so
gcc -o without_lock without_lock.c -I../lib ../build/lib/lib_tsx_mpk.so
gcc without_lock_llvm.o ../build/lib/lib_tsx_mpk.so -o without_lock_llvm
```
