# Basic setup information
url --url="http://mirror.centos.org/centos/8/BaseOS/aarch64/os/"
%include includes/centoscommon8.ksi

# Repositories to use
repo --name="centos8-baseos"    --baseurl=http://mirror.centos.org/centos/8/BaseOS/aarch64/os/
repo --name="centos8-appstream" --baseurl=http://mirror.centos.org/centos/8/AppStream/aarch64/os/
repo --name="instKernP" --baseurl=https://people.centos.org/pgreco/rpi_aarch64_el8_5.10/ --cost=1000
