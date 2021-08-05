# Basic setup information
url --url="https://repo.almalinux.org/almalinux/8/BaseOS/aarch64/os/"
%include includes/almacommon8.ksi

# Repositories to use
repo --name="almalinux8-baseos"    --baseurl=https://repo.almalinux.org/almalinux/8/BaseOS/aarch64/os/
repo --name="almalinux8-appstream" --baseurl=https://repo.almalinux.org/almalinux/8/AppStream/aarch64/os/
repo --name="instKernP" --baseurl=https://people.centos.org/pgreco/rpi_aarch64_el8_5.10/ --cost=1000 --install
