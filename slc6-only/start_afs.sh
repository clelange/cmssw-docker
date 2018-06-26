#!/bin/bash
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi
unamestr=`uname`
if [[ "$unamestr" -ne "Linux" ]]; then
  echo "This works only with Linux as host system"
  exit
fi
echo "Installing afs service"
echo /lib/modules/2.6.32-696.30.1.el6.x86_64/fs/openafs/openafs.ko | openafs-modules --add-modules
/sbin/chkconfig --add afs
/sbin/service afs start