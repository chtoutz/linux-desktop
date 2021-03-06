#!/bin/bash

if [ "$EUID" -ne 0 ]
    then echo "must run as root"
        exit
fi

# running commands to configure the system
printf "[main]\ndhcp=dhclient" > /etc/NetworkManager/conf.d/dhcp-client.conf
printf "[Policy]\nAutoEnable=true" > /etc/bluetooth/main.conf
# echo "ControllerMode = bredr" >> /etc/bluetooth/main.conf

# disable annoying beep
echo "blacklist pcspkr" | tee /etc/modprobe.d/nobeep.conf
systemctl enable NetworkManager
systemctl enable bluetooth
timedatectl set-ntp true

#mkinitcpio -p linux

# map vim to nvim
#ln -sf /usr/bin/nvim /usr/bin/vim

localectl set-locale LANG=fr_FR.UTF-8
# Persist keyboard mapping on Xorg
localectl set-x11-keymap fr

# cp -r ../scripts/usr/local/bin/bye /usr/local/bin/
# cp -r ../scripts/usr/local/bin/importc /usr/local/bin/

# make vconsole font larger
# VCONSOLE_FONT=FONT=ter-v32n.psf.gz
# touch /etc/vconsole.conf
# grep -qxF ${VCONSOLE_FONT} /etc/vconsole.conf || sudo echo ${VCONSOLE_FONT} >> /etc/vconsole.conf

# set grub font size
# grub-mkfont -s 60 -o /boot/grubfont.pf2 /usr/share/fonts/TTF/Hack-Regular.ttf
# GRUB_FONT=GRUB_FONT=\"/boot/grubfont.pf2\"
# grep -qxF ${GRUB_FONT} /etc/default/grub || echo ${GRUB_FONT} >> /etc/default/grub

# update grub config
# grub-mkconfig -o /boot/grub/grub.cfg
