# SLC6 OS capable of using/running CMS software release(s).

# Make the base image configurable:
ARG BASEIMAGE=cern/slc6-base:latest

# Set up the SLC6 CMSSW base:
FROM ${BASEIMAGE}

LABEL maintainer="Clemens Lange <clemens.lange@cern.ch>"

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
LABEL   org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="SLC6 CMS base OS" \
        org.label-schema.description="SLC6 OS capable of using/running CMS software release(s)." \
        org.label-schema.url="http://cms-sw.github.io/" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url=$VCS_URL \
        org.label-schema.vendor="CERN" \
        org.label-schema.version=$VERSION \
        org.label-schema.schema-version="1.0"

# Perform the installation as root
USER root
WORKDIR /root

RUN     yum install -y libXft-devel libX11-devel libXpm-devel libXext-devel mesa-libGLU-devel \
        libXmu libXpm \
        HEP_OSlibs_SL6 wget git \
        tcsh zsh tcl \
        perl-ExtUtils-Embed perl-libwww-perl \
        compat-libstdc++-33 \
        zip e2fsprogs \
        CERN-CA-certs voms-clients-cpp ca-policy-lcg \
        krb5-devel cern-wrappers krb5-workstation \
        strace sudo && \
        yum clean -y all

RUN     groupadd -g 1000 cmsusr && adduser -u 1000 -g 1000 cmsusr && \
        echo "cmsusr ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers && \
        groupadd -g 1001 cmsinst && adduser -u 1001 -g 1001 cmsinst && \
        install -d /opt && install -d -o cmsinst /opt/cms

# Add a couple of useful files to cmsusr account
WORKDIR /home/cmsusr
USER cmsusr
ENV USER cmsusr
ENV HOME /home/cmsusr
ENV VO_CMS_SW_DIR       /cvmfs/cms.cern.ch
ENV CMS_LOCAL_ROOT_BASE /cvmfs/cms.cern.ch

ADD dot-pythonrc.py $HOME/.pythonrc.py
ADD dot-bashrc      $HOME/.bashrc
ADD dot-bashrc      $HOME/.zshrc

CMD     ["/bin/zsh"]