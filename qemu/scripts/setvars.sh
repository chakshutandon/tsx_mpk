#!/bin/bash
set -x

#Pass the release name
export BASE=$PWD
export OS_RELEASE_NAME=$(sed -n 's/^\UBUNTU_CODENAME=//p' < /etc/os-release)
export QEMU_IMG=$BASE
export KERN_SRC=$BASE/KERNEL/linux-4.4.212
export KERNEL=$BASE/KERNEL
#CPU parallelism
export PARA=`nproc`
export VER="4.4.212"
export QEMU_IMG_FILE=$PWD/qemu-image.img
export QEMU_SWAP_FILE=$PWD/qemu-swap.img
export MOUNT_DIR=$PWD/mountdir
export QEMUMEM="2096M"
set +x
