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
%include includes/precommon8.ksi

%post
# Mandatory README file
cat >/root/README << EOF
== Rocky Linux 8 ==

If you want to automatically resize your / partition, just type the following (as root user):
rootfs-expand

EOF

cat > /boot/config.txt << EOF
# Rocky doesn't use any default config options to work,
# this file is provided as a placeholder for user options
EOF

# Setting correct yum variable to use raspberrypi kernel repo
#echo "rpi2" > /etc/dnf/vars/kvariant

%end

%include includes/postcommon8.ksi
%include includes/fixcmdline8.ksi
