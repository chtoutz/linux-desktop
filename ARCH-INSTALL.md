# Installing Arch Linux

Many thanks to [octetz](https://octetz.com/docs/2020/2020-2-16-arch-windows-install/) !!

## General
This section covers installing Arch Linux. Using Linux Unified Key Setup (LUKS), the root partition will be encrypted.

### Installing system

#### Prepare host machine
1. Insert the USB containing Arch Linux.
1. Boot the machine.
1. Load french keyboard.
```
loadkeys fr
```
1. If no ethernet, connect to wifi.
```
iwctl
station [wlan0] connect [SSID]
```
1. Validate connectivity.
```
ping google.com
PING google.com (216.58.193.206) 56(84) bytes of data.
64 bytes from lax02s23-in-f14.1e100.net time=809 ms
64 bytes from lax02s23-in-f14.1e100.net time=753 ms
```
1. Set a root passwd for archiso.
```
passwd
```
1. Enable sshd.
```
systemctl start sshd
```
1. Determine your local address using ```ip a```
1. From another machine, ssh in (this allows to have access to c/c, browser...).

#### Configure from guest machine

##### Disk partitionning
1. List block devices to determine the name of the drive w/ ```lsblk```.
2. Launch cgdisk for the drive above.
```
cgdisk /dev/sda
```
3. Delete all existing partitions if any, and create new ones :

```
Part. #     Size        Partition Type            Partition Name
----------------------------------------------------------------
            1007.0 KiB  free space
   1        100.0 MiB   EFI system partition      EFI system partition
   2        512.0 MiB   Linux filesystem          boot
   3        118.6 GiB   Linux filesystem          root
```
**Note** : separate boot partition allows to select OS in grub menu before having to type passwd (especially useful if dual booting)
4. Choose ```[ Write ]``` and say yes.
1. Choose ```[ Quit ]```.

##### Encrypting and Configuring the Root Partition
1. Encrypt the root partition
```
cryptsetup -y --use-random luksFormat /dev/sda3
```
1. Open the LUKS device
```
cryptsetup luksOpen /dev/sda3 cryptroot
```
1. Run ```lsblk``` to view the new volume relationship (should see "cryptroot" part under sda3).
1. Format the partitions.
```
mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/mapper/cryptroot
```

##### Mounting and installing
1. Create & mount partitions (in that order ;))
```
mount /dev/mapper/cryptroot /mnt
mkdir /mnt/boot && mount /dev/sda2 /mnt/boot
mkdir /mnt/boot/efi && mount -t vfat /dev/sda1 /mnt/boot/efi
```
1. Install packages on the root file system.
```
pacstrap /mnt linux linux-firmware base base-devel [intel | amd]-ucode grub efibootmgr vim nano git networkmanager dhclient dhcpcd openssh
```
1. Generate file system table (fstab) for mounting partitions.
```
genfstab -U /mnt >> /mnt/etc/fstab
```

##### System Configuration
This section enters the new Arch Linux system and configures the system.

1. Enter the system root via arch-chroot.
```
arch-chroot /mnt
```
1. Set the time zone.
```
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
```
1. Set the Hardware Clock from the System Clock, and update the timestamps in /etc/adjtime.
```
hwclock --systohc
```
1. Uncomment locales in /etc/locale.gen.
```
...
en_US.UTF-8 UTF-8  
...
fr_FR.UTF-8 UTF-8  
```
1. Generate locale.
```
locale-gen
```
1. Set the LANG variable to the same locale in /etc/locale.conf, and activate it for live session.
```
echo "LANG=fr_FR.UTF-8" >> /etc/locale.conf
export LANG=fr_FR.UTF-8
```
1. Persist keyboard mapping.
```
echo KEYMAP=fr > /etc/vconsole.conf
```
1. Set hostname & hosts accordingly
```
echo "Archtoutz" > /etc/hostname
echo '127.0.0.1 localhost' >> /etc/hosts
echo '::1   localhost' >> /etc/hosts
echo '127.0.1.1 Archtoutz.localdomain  Archtoutz' >> /etc/hosts
```

##### Initial RAM disk configuration
1. Add *encrypt* & *keymap* to HOOKS in ```/etc/mkinitcpio.conf```, and move *keyboard* before *modconf* (order matters).
```
HOOKS=(base udev autodetect keyboard keymap modconf block encrypt filesystems fsck)
```
1. Build initramfs with the linux preset.
```
mkinitcpio -p linux
```

##### GRUB Bootloader Setup
1. Determine the UUID of your **root** (sda3) partition and EFI partition with ```blkid```.
1. Edit the GRUB boot loader configuration.
```
nano /etc/default/grub
```
1. Update the GRUB_CMDLINE_LINUX to match the format cryptdevice=UUID=${ROOT_UUID}:cryptroot root=/dev/mapper/cryptroot where ${ROOT_UUID} is the UUID captured above.
```
GRUB_CMDLINE_LINUX="cryptdevice=UUID=4f7301bf-a44f-4b90-ad6d-5ec10a0c2f2a:cryptroot root=/dev/mapper/cryptroot"
```
1. Install grub.
```
grub-install
```
1. Generate the grub configuration.
```
grub-mkconfig -o /boot/grub/grub.cfg
```

##### User Administration

1. Set the root password.
```
passwd
```
1. Add a user.
```
useradd -m -G wheel stutz
```
-G adds the user to a group. -m creates a home directory.
1. Set the user's password.
```
passwd stutz
```
1.Enter visudo.
```
EDITOR=nano visudo
```
1. Uncomment the lines that allow users of group wheel to sudo.
```
%wheel ALL=(ALL) ALL
```

##### Enable Networking
Enable NetworkManager to ensure it starts after boot.
```
systemctl enable NetworkManager
```

##### Rebooting

1. Exit the arch-chroot
```
exit
```
1. Unmount the partitions.
```
umount -R /mnt
```
1. Reboot.
```
reboot
```
1. Using grub, login to Arch linux.
1. Use ```nmtui-connect``` to establish internet and begin installing packages.
___
Edited 2021-02-21

** ALWAYS CHECK LATEST ARCH WIKI BEFORE INSTALL **
