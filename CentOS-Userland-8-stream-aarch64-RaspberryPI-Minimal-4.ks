# Basic setup information
url --url="http://mirror.centos.org/centos/8/BaseOS/aarch64/os/"
rootpw --plaintext centos
%include includes/basecommon8.ksi

# Repositories to use
repo --name="centos8-stream-baseos"    --baseurl=http://mirror.centos.org/centos/8-stream/BaseOS/aarch64/os/
repo --name="centos8-stream-appstream" --baseurl=http://mirror.centos.org/centos/8-stream/AppStream/aarch64/os/
repo --name="instKernP" --baseurl=https://people.centos.org/pgreco/rpi_aarch64_el8_5.10/ --cost=1000

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
== CentOS 8 userland ==

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
# CentOS doesn't use any default config options to work,
# this file is provided as a placeholder for user options
EOF

# Setting correct yum variable to use raspberrypi kernel repo
echo "rpi2" > /etc/dnf/vars/kvariant

# Remove ifcfg-link on pre generated images
rm -f /etc/sysconfig/network-scripts/ifcfg-link

# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id

%end

%include includes/fixcmdline8.ksi
