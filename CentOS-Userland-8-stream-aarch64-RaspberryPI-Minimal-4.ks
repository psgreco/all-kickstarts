# Basic setup information
url --url="http://mirror.centos.org/centos/8-stream/BaseOS/aarch64/os/"
%include includes/centoscommon8.ksi

# Repositories to use
repo --name="centos8-stream-baseos"    --baseurl=http://mirror.centos.org/centos/8-stream/BaseOS/aarch64/os/
repo --name="centos8-stream-appstream" --baseurl=http://mirror.centos.org/centos/8-stream/AppStream/aarch64/os/
repo --name="instKernP" --baseurl=https://people.centos.org/pgreco/rpi_aarch64_el8_5.10/ --cost=1000
