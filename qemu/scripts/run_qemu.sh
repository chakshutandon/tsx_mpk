#!/bin/bash
set -x

sudo umount $MOUNT_DIR

#Launching QEMU
sudo qemu-system-x86_64                                                         \
    -nographic                                                                  \
    -kernel $KERN_SRC/arch/x86_64/boot/bzImage                                  \
    -hda $QEMU_IMG_FILE                                                         \
    -hdb $QEMU_SWAP_FILE                                                        \
    -cpu qemu64,+pku,+xsave                                                     \
    -append 'root=/dev/sda rw console=ttyS0'                                    \
    -m $QEMU_MEM                                                                \
    -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:22        \
    -smp cores=$QEMU_NR_CORES                                                   \

set +x

