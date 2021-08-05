# Basic setup information
url --url="https://repo.almalinux.org/almalinux/8/BaseOS/aarch64/os/"
install
keyboard us --xlayouts=us --vckeymap=us
rootpw --plaintext almalinux
timezone --isUtc --nontp UTC
selinux --enforcing
firewall --enabled --port=22:tcp
network --bootproto=dhcp --device=link --activate --onboot=on
services --enabled=sshd,NetworkManager,chronyd
shutdown
bootloader --location=mbr
lang en_US.UTF-8

# Repositories to use
repo --name="almalinux8-baseos"    --baseurl=https://repo.almalinux.org/almalinux/8/BaseOS/aarch64/os/
repo --name="almalinux8-appstream" --baseurl=https://repo.almalinux.org/almalinux/8/AppStream/aarch64/os/
repo --name="instKernP" --baseurl=https://people.centos.org/pgreco/rpi_aarch64_el8_5.10/ --cost=1000 --install

# Disk setup
clearpart --initlabel --all
part /boot --asprimary --fstype=vfat --size=300 --label=boot
part swap --asprimary --fstype=swap --size=512 --label=swap
part / --asprimary --fstype=ext4 --size=2400 --label=rootfs

%include includes/packages8.ksi

%pre

#End of Pre script for partitions
%end

%post
# Generating initrd
export kvr=$(rpm -q --queryformat '%{version}-%{release}' $(rpm -q raspberrypi2-kernel4|tail -n 1))
#dracut --force /boot/initramfs-$kvr.armv7hl.img $kvr.armv7hl


# Mandatory README file
cat >/root/README << EOF
== Alma Linux 8 ==

If you want to automatically resize your / partition, just type the following (as root user):
rootfs-expand

EOF

# Enabling chronyd on boot
systemctl enable chronyd


# Specific cmdline.txt files needed for raspberrypi2/3
cat > /boot/cmdline.txt << EOF
console=ttyAMA0,115200 console=tty1 root=/dev/mmcblk0p3 rootfstype=ext4 elevator=deadline rootwait
EOF

cat > /boot/config.txt << EOF
# AlmaLinux doesn't use any default config options to work,
# this file is provided as a placeholder for user options
EOF

# Setting correct yum variable to use raspberrypi kernel repo
#echo "rpi2" > /etc/dnf/vars/kvariant

# Remove ifcfg-link on pre generated images
rm -f /etc/sysconfig/network-scripts/ifcfg-link

# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

%end

%post --nochroot --erroronfail

/usr/sbin/blkid
LOOPPART=$(cat /proc/self/mounts |/usr/bin/grep '^\/dev\/mapper\/loop[0-9]p[0-9] '"$INSTALL_ROOT " | /usr/bin/sed 's/ .*//g')
echo "Found loop part for PARTUUID $LOOPPART"
BOOTDEV=$(/usr/sbin/blkid $LOOPPART|grep 'PARTUUID="........-03"'|sed 's/.*PARTUUID/PARTUUID/g;s/ .*//g;s/"//g')
echo "no chroot selected bootdev=$BOOTDEV"
if [ -n "$BOOTDEV" ];then
    cat $INSTALL_ROOT/boot/cmdline.txt
    echo sed -i "s|root=/dev/mmcblk0p3|root=${BOOTDEV}|g" $INSTALL_ROOT/boot/cmdline.txt
    sed -i "s|root=/dev/mmcblk0p3|root=${BOOTDEV}|g" $INSTALL_ROOT/boot/cmdline.txt
fi
cat $INSTALL_ROOT/boot/cmdline.txt
%end
