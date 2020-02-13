# A container containing a specific CMSSW release

# Make the base image configurable:
ARG BASEIMAGE=clelange/slc6-cms:latest

# Set up the SLC6 CMSSW base:
FROM ${BASEIMAGE}

LABEL maintainer="Clemens Lange <clemens.lange@cern.ch>"

ARG SCRAM_ARCH=slc6_amd64_gcc481
ARG CMSSW_VERSION=CMSSW_7_1_25_patch5

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION
LABEL   org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="CMSSW Docker standalone images ${SCRAM_ARCH} ${CMSSW_VERSION}" \
        org.label-schema.description="Provide completely offline-runnable CMSSW images." \
        org.label-schema.url="http://cms-sw.github.io/" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url=$VCS_URL \
        org.label-schema.vendor="CERN" \
        org.label-schema.version=$VERSION \
        org.label-schema.schema-version="1.0"

# cannot install CMSSW as root
USER    cmsinst
WORKDIR /opt/cms

RUN     wget -q https://github.com/cms-sw/siteconf/archive/master.tar.gz \
        && tar -xzf master.tar.gz \
        && mv siteconf-master SITECONF \
        && wget -O /opt/cms/bootstrap.sh http://cmsrep.cern.ch/cmssw/repos/bootstrap.sh \
        && sh /opt/cms/bootstrap.sh setup -r cms -architecture ${SCRAM_ARCH} -server cmsrep.cern.ch \
        && /opt/cms/common/cmspkg -a ${SCRAM_ARCH} install -y cms+cmssw+${CMSSW_VERSION%_p*} \
        && if [[ $CMSSW_VERSION = *"patch"* ]]; then /opt/cms/common/cmspkg -a ${SCRAM_ARCH} install -y cms+cmssw-patch+${CMSSW_VERSION}; fi \
        && /opt/cms/common/cmspkg -a ${SCRAM_ARCH} clean

USER    root
RUN     /bin/cp -f /opt/cms/cmsset_default.sh /etc/profile.d/

USER    cmsusr
WORKDIR /home/cmsusr
ENV     CMSSW_VERSION=${CMSSW_VERSION}
ENV     SCRAM_ARCH=${SCRAM_ARCH}
ADD     entrypoint.sh /opt/cms/entrypoint.sh
RUN     sudo chmod 755 /opt/cms/entrypoint.sh && \
        sudo chown -R cmsusr /home/cmsusr && \
        chmod 755 /home/cmsusr

ENTRYPOINT ["/opt/cms/entrypoint.sh"]
CMD     ["/bin/zsh"]
