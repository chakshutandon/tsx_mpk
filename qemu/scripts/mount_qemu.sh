#!/bin/bash
set -x

mkdir -p $MOUNT_DIR
#Next, mount your image to the directory
sudo mount -o loop $QEMU_IMG_FILE $MOUNT_DIR
