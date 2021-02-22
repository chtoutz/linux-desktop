#!/bin/bash

if [ "$EUID" -ne 0 ]
    then echo "must run as root"
        exit
fi

loadkeys fr
# lsblk
cryptsetup luksOpen /dev/sda3 cryptroot
# enter password

# Re-mount partitions
# lsblk
mount /dev/mapper/cryptroot /mnt
mount /dev/sda2 /mnt/boot
mount /dev/sda1 /mnt/boot/efi
# lsblk

arch-chroot /mnt

iwctl
station wlan0 connect StutzBox
