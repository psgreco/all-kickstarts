# Basic setup information
url --url="https://download.rockylinux.org/pub/rocky/8/BaseOS/aarch64/os/"
rootpw --plaintext rocky
%include includes/basecommon8.ksi

# Repositories to use
repo --name="rocky8-baseos"    --baseurl=https://download.rockylinux.org/pub/rocky/8/BaseOS/aarch64/os/
repo --name="rocky8-appstream" --baseurl=https://download.rockylinux.org/pub/rocky/8/AppStream/aarch64/os/
repo --name="instKernP" --baseurl=https://people.centos.org/pgreco/rpi_aarch64_el8_5.10/ --cost=1000

%include includes/partitions8.ksi
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
== Rocky Linux 8 ==

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
# Rocky doesn't use any default config options to work,
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

%include includes/fixcmdline8.ksi
