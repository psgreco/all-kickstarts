# Basic setup information
url --url="https://download.rockylinux.org/pub/rocky/8/BaseOS/aarch64/os/"
%include includes/rockycommon8.ksi

# Repositories to use
repo --name="rocky8-baseos"    --baseurl=https://download.rockylinux.org/pub/rocky/8/BaseOS/aarch64/os/
repo --name="rocky8-appstream" --baseurl=https://download.rockylinux.org/pub/rocky/8/AppStream/aarch64/os/
repo --name="instKernP" --baseurl=https://people.centos.org/pgreco/rpi_aarch64_el8_5.10/ --cost=1000
