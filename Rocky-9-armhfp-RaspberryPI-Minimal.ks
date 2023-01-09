# Basic setup information
url --url="https://dl.fedoraproject.org/pub/archive/fedora/linux/releases/34/Everything/armhfp/os/"
# Repositories to use
#repo --name="rocky9-baseos"    --baseurl=https://dl.fedoraproject.org/pub/archive/fedora/linux/releases/34/Everything/armhfp/os/
repo --name="round1"            --baseurl=file:///root/results.round1/
repo --name="local"            --baseurl=file:///root/results/
repo --name="localbootstrap"   --baseurl=file:///root/results.bootstrap/

%include includes/userrocky9.ksi
%include includes/basecommon9.ksi
%include includes/rpi-partitions9.ksi
%include includes/packages9.ksi

# Package setup
%packages
#raspberrypi-vc-utils
raspberrypi2-firmware
raspberrypi2-kernel
-kexec-tools

%end

%include includes/precommon9.ksi
%include includes/readmecommon.ksi
%include includes/rpi-postcommon9.ksi
%include includes/postcommon9.ksi
%include includes/rpi-fixcmdline9.ksi
