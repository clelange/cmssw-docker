##
## A container where CernVM-FS is up and running for CMSSW
FROM cern/slc6-base
LABEL maintainer="Clemens Lange clemens.lange@cern.ch"

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION
LABEL   org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="CMSSW Docker images for mounting /cvmfs separately" \
        org.label-schema.description="Provide lightweight images for running CMSSW." \
        org.label-schema.url="http://cms-sw.github.io/" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url=$VCS_URL \
        org.label-schema.vendor="CERN" \
        org.label-schema.version=$VERSION \
        org.label-schema.schema-version="1.0"

USER root

# Install rpms
RUN yum update -y && yum install -y \
    sudo \
    glibc-headers time \
    man nano openssh-server openssl098e libXext libXpm libXft libSM \
	zsh \
    glibc-devel.i686 glibc-devel && \
    yum install -y -q wget git \
    openafs-krb5 openafs-client openafs-module-tools && \
    yum clean -y all

# add kerberos and afs configs
ADD krb5.conf /etc/krb5.conf
ADD afs/etc /usr/vice/etc
ADD openafs.ko /lib/modules/2.6.32-696.30.1.el6.x86_64/fs/openafs/openafs.ko
# RUN echo /lib/modules/2.6.32-696.30.1.el6.x86_64/fs/openafs/openafs.ko | openafs-modules --add-modules && \
    # /sbin/chkconfig --add afs && \
    # /sbin/service afs start

RUN adduser cmsusr && \
    echo "cmsusr ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

WORKDIR /home/cmsusr
USER cmsusr
ENV USER cmsusr
ENV HOME /home/cmsusr
ENV VO_CMS_SW_DIR       /cvmfs/cms.cern.ch
ENV CMS_LOCAL_ROOT_BASE /cvmfs/cms.cern.ch

ADD dot-pythonrc.py $HOME/.pythonrc.py
ADD dot-bashrc      $HOME/.bashrc
ADD dot-bashrc      $HOME/.zshrc

ENTRYPOINT /bin/zsh
