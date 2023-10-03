#!/usr/bin/env bash

systemctl stop sshd.service

parted /dev/sda --script mklabel gpt
parted /dev/sda --script --align=optimal mkpart esp fat32 1MiB 1GiB set 1 esp on
parted /dev/sda --script --align=optimal mkpart primary ext4 1GiB 100%

mkfs.ext4 -L "root" /dev/sda2
mkfs.vfat -F32 /dev/sda1

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount -o uid=0,gid=0,fmask=0077,dmask=0077 /dev/sda1 /mnt/boot

pacstrap -K /mnt base base-devel linux linux-firmware

genfstab -U /mnt >> /mnt/etc/fstab

cp bootstrap-system.sh /mnt/bootstrap-system.sh
arch-chroot /mnt /bootstrap-system.sh
rm /mnt/bootstrap-system.sh

umount -R /mnt

/usr/bin/useradd  --create-home --user-group ${username}
echo -e "${password}\n${password}" | /usr/bin/passwd ${username}
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_${username}
echo '${username} ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_${username}
/usr/bin/chmod 0440 /etc/sudoers.d/10_${username}

systemctl start sshd.service
