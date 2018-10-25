#!/bin/sh
set  -e

echo "::: Setting up CMS environment\
 (works only if /cvmfs is mounted on host) ..."
if [ -f /cvmfs/cms.cern.ch/cmsset_default.sh ]; then
  source /cvmfs/cms.cern.ch/cmsset_default.sh
  echo "::: Setting up CMS environment... [done]"
else
  echo "::: ERROR: Could not set up CMS environment... [done]"
fi
exec "$@"
