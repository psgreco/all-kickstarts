# Basic setup information
url --url="https://dl.fedoraproject.org/pub/archive/fedora/linux/releases/34/Everything/armhfp/os/"
# Repositories to use
#repo --name="rocky9-baseos"    --baseurl=https://dl.fedoraproject.org/pub/archive/fedora/linux/releases/34/Everything/armhfp/os/
repo --name="round1"            --baseurl=file:///root/results.round1/
repo --name="local"            --baseurl=file:///root/results/
repo --name="localbootstrap"   --baseurl=file:///root/results.bootstrap/

%include includes/userrocky9.ksi
%include includes/basecommon9.ksi
%include includes/gen-partitions9.ksi
%include includes/packages9.ksi

# Package setup
%packages
extlinux-bootloader
grubby-deprecated
dracut-config-generic
kernel
kernel-core
grub2-common
#grub2-efi-aa64
#grub2-efi-aa64-modules
#grubby
efibootmgr
#shim-aa64
systemd-udev
-dracut-config-rescue

%end


%include includes/precommon9.ksi
%include includes/readmecommon.ksi
%include includes/gen-postcommon9.ksi
%include includes/gen-rockypost9.ksi
%include includes/postcommon9.ksi
