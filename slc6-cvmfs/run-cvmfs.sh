#!/bin/sh
sudo chgrp fuse /dev/fuse
echo "::: cvmfs-config..."
sudo cvmfs_config setup || exit 1

echo "::: mounting FUSE..."
sudo mount -a
echo "::: mounting FUSE... [done]"

if [ -f /cvmfs/cms.cern.ch/cmsset_default.sh ]
then
    echo "::: Mounting CVMFS... [done]"
else
    echo "::: Mounting CVMFS... [FAILED]"
    echo "::: Did you run the docker container in privileged mode?"
fi
