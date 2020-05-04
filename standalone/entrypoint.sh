#!/bin/bash
set  -e

echo "Setting up ${CMSSW_VERSION}"
source /opt/cms/cmsset_default.sh
cd /home/cmsusr
scramv1 project CMSSW ${CMSSW_VERSION}
cd ${CMSSW_VERSION}/src
eval `scramv1 runtime -sh`
echo "CMSSW should now be available."

exec "$@"
