#!/bin/bash
set -x

#Now create a disk for your virtual machine 
qemu-img create $QEMU_IMG_FILE $QEMU_IMG_SIZE
qemu-img create $QEMU_SWAP_FILE $QEMU_SWAP_SIZE

#Now format your disk with some file system; 
#ext4 in this example
sudo mkfs.ext4 $QEMU_IMG_FILE

#Now create a mount point directory for your image file
mkdir -p $MOUNT_DIR

#Next, mount your image to the directory
sudo mount -o loop $QEMU_IMG_FILE $MOUNT_DIR

#Install debootstrap
sudo apt-get install debootstrap

#Set family name 
sudo debootstrap --arch amd64 $OS_RELEASE_NAME  $MOUNT_DIR

#Unmount
sudo umount $MOUNT_DIR

#Chroot and Now install all your required packages; lets start with vim and build_esstentials.
#sudo chroot $MOUNT_DIR && sudo apt-get install vim && sudo apt-get install build-essential && sudo apt-get install ssh

#You are all set. Now unmount your image file from the directory.
exit
