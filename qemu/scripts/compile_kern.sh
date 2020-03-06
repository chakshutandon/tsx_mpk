#!/bin/bash
set -x

#If current mounted, unmount
sudo umount $MOUNT_DIR

#Compile the kernel
cd $KERN_SRC

#Enable the KVM mode in your kernel config file
sudo make x86_64_defconfig

#Compile the kernel with '-j' (denotes parallelism) in sudo mode
sudo make -j$(nproc)

set +x
