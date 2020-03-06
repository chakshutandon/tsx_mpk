#!/bin/bash
set -x

#Pass the release name
export ROOT=$(dirname $PWD)
export KERN_SRC=$ROOT/linux

export KERN_VER="4.9.215"
export OS_RELEASE_NAME="buster"

export BASE=$PWD

export QEMU_IMG_FILE=$BASE/debian-buster.img
export QEMU_SWAP_FILE=$BASE/qemu-swap.img

export MOUNT_DIR=$BASE/debian

export QEMU_NR_CORES=4

export QEMU_IMG_SIZE="16G"
export QEMU_SWAP_SIZE="3G"

export QEMU_MEM="2096M"

set +x
