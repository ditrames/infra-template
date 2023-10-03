ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime

hwclock --systohc

sed "/en_GB.UTF-8/s/^#//" -i /etc/locale.gen

locale-gen

echo "LANG=en_GB.UTF-8" > /etc/locale.conf

echo "arch-template" > /etc/hostname

pacman --sync --noconfirm mkinitcpio

mkinitcpio -p linux


bootctl --path=/boot install

{
    echo 'default arch.conf'
    echo 'timeout 3'
    echo 'console-mode max'
    echo 'editor   no'
} > /boot/loader/loader.conf

{
    echo 'title Arch Linux'
    echo 'linux /vmlinuz-linux'
    echo 'initrd /initramfs-linux.img'
    echo 'options root="LABEL=root" rw'
} > /boot/loader/entries/arch.conf

{
    echo 'title Arch Linux fallback'
    echo 'linux /vmlinuz-linux'
    echo 'initrd /initramfs-linux-fallback.img.img'
    echo 'options root="LABEL=root" rw'
} > /boot/loader/entries/arch-fallback.conf



/usr/bin/useradd  --create-home --user-group ${username}
echo -e "${password}\n${password}" | /usr/bin/passwd ${username}
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_${username}
echo '${username} ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_${username}
/usr/bin/chmod 0440 /etc/sudoers.d/10_${username}

pacman -Sy --noconfirm dhcpcd openssh qemu-guest-agent


systemctl start qemu-guest-agent

systemctl enable dhcpcd@enp6s18.service

systemctl enable sshd.service