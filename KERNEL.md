## Compiling Linux Kernel (in Ubuntu)
 There is a helpful [How-To Page](https://kernelnewbies.org/KernelBuild) 
 and [this one](https://medium.freecodecamp.org/building-and-installing-the-latest-linux-kernel-from-source-6d8df5345980) 
 for you to reference at. 
```
$ sudo apt-get update
$ sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc
```

* Change directory
```
cd linux
```

* Make config file and compile
```
$ make x86_64_defconfig
$ make -j$(nproc)
```
