#!/bin/bash
set -x

#Launching QEMU
#sudo qemu-system-x86_64 -kernel $KERNEL/vmlinuz-$VER -hda $QEMU_IMG_FILE -append "root=/dev/sda rw" --curses -m $QEMUMEM -hdb $QEMU_SWAP_FILE -smp cores=32 -cpu host -enable-kvm -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:22
sudo qemu-system-x86_64 -kernel $KERNEL/vmlinuz-$VER -hda $QEMU_IMG_FILE -append "root=/dev/sda rw" --curses -m 8048M -hdb $QEMU_SWAP_FILE -smp cores=32 -cpu host -enable-kvm -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:22

set +x

