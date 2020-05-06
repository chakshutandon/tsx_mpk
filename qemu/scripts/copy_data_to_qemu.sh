#!/bin/bash
set -x

#Full path of directory or file to copy
DIRPATH=$1

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
QEMU_DIR="$(dirname "$SCRIPT_DIR")"
ROOT_DIR="$(dirname "$QEMU_DIR")"

#Next, mount your image to the directory
sudo mount -o loop $QEMU_IMG_FILE $MOUNT_DIR

if [ -z "$DIRPATH" ]
then
    sudo cp -r $ROOT_DIR/build $MOUNT_DIR/root/
    sudo cp -r $ROOT_DIR/include $MOUNT_DIR/root/
    sudo cp -r $ROOT_DIR/src $MOUNT_DIR/root/
    sudo cp -r $ROOT_DIR/Makefile $MOUNT_DIR/root/
    sudo cp -r $ROOT_DIR/bin $MOUNT_DIR/root/
else
    sudo cp -r $DIRPATH $MOUNT_DIR/root/
fi

sudo umount $MOUNT_DIR
