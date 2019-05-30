#!/bin/sh
set  -e

/etc/cvmfs/run-cvmfs.sh

echo "::: Setting up CMS environment..."
source /cvmfs/cms.cern.ch/cmsset_default.sh
echo "::: Setting up CMS environment... [done]"

exec "$@"
