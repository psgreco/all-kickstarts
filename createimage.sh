#!/bin/bash
KSFILE=$1
KSNAME=${KSFILE%.ks}

if [ ! -f "${KSFILE}" ]; then
  echo
  echo "SYNOPSIS"
  echo "   $0 <KICKSTARTFILE>"
  echo
  echo "EXAMPLE"
  echo "   $0 CentOS-Userland-8-stream-aarch64-RaspberryPI-Minimal-4.ks"
  echo
  exit 1
fi

set -x
appliance-creator -c ${KSFILE} \
                  -d -v --logfile /var/tmp/${KSNAME}.log \
                  --cache /root/cache --no-compress \
                  -o /var/tmp/appoutput --format raw --name ${KSNAME} | tee /var/tmp/${KSNAME}.log.2
