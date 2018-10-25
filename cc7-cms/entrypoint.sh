#!/bin/sh
set  -e

echo "::: Setting up CMS environment\
 (works only if /cvmfs is mounted on host) ..."
source /cvmfs/cms.cern.ch/cmsset_default.sh
echo "::: Setting up CMS environment... [done]"

exec "$@"
