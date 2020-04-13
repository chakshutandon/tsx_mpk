#!/bin/bash
set -x

# export SCRIPT_PATH=$(realpath $BASH_SOURCE)
export QEMU_ROOT=$(dirname $(dirname $(realpath $BASH_SOURCE)))
export PROJECT_ROOT=$(dirname $QEMU_ROOT)
#Pass the release name
export KERN_SRC=$PROJECT_ROOT/linux
export KERN_VER="4.9.215"
export OS_RELEASE_NAME="buster"

export QEMU_IMG_FILE=$QEMU_ROOT/debian-buster.img
export QEMU_SWAP_FILE=$QEMU_ROOT/qemu-swap.img

export MOUNT_DIR=$QEMU_ROOT/debian

export QEMU_NR_CORES=4

export QEMU_IMG_SIZE="16G"
export QEMU_SWAP_SIZE="3G"

export QEMU_MEM="2096M"

set +x
