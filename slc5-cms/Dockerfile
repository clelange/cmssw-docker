# SLC5 OS capable of using/running CMS software release(s).

# Make the base image configurable:
ARG BASEIMAGE=cern/slc5-base:latest

# Set up the SLC5 CMSSW base:
FROM ${BASEIMAGE}

LABEL maintainer="Clemens Lange <clemens.lange@cern.ch>"

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION
LABEL   org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="SLC5 CMS base OS" \
        org.label-schema.description="SLC5 OS capable of using/running CMS software release(s)." \
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
        libXmu libXpm libSM libXft libXext \
        wget git \
        glibc-devel \
        tcsh zsh tcl \
        perl-libwww-perl \
        compat-libstdc++-33 zip \
        voms-clients-cpp python-simplejson \
        tk mesa-libGLU mesa-libGL \
        krb5-devel cern-wrappers krb5-workstation \
        time strace sudo && \
        yum clean -y all

RUN     wget http://repository.egi.eu/sw/production/cas/1/current/repo-files/EGI-trustanchors.repo && \
        mv EGI-trustanchors.repo /etc/yum.repos.d/ && \
        wget http://repository.egi.eu/sw/production/cas/1/GPG-KEY-EUGridPMA-RPM-3 && \
        mv GPG-KEY-EUGridPMA-RPM-3 /etc/pki/rpm-gpg/ && \
        wget http://linuxsoft.cern.ch/wlcg/wlcg-sl5.repo && \
        mv wlcg-sl5.repo /etc/yum.repos.d/ && \
        wget http://linuxsoft.cern.ch/wlcg/RPM-GPG-KEY-wlcg && \
        mv RPM-GPG-KEY-wlcg /etc/pki/rpm-gpg/ && \
        wget http://grid-deployment.web.cern.ch/grid-deployment/download/HEP/repo/HEP_OSlibs.repo && \
        mv HEP_OSlibs.repo /etc/yum.repos.d/ && \
        yum install -y HEP_OSlibs_SL5 ca-policy-lcg ca-policy-egi-core wlcg-repo.noarch wlcg-voms-cms && \
        yum clean -y all

RUN     groupadd -g 1000 cmsusr && adduser -u 1000 -g 1000 cmsusr && \
        echo "cmsusr ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers && \
        groupadd -g 1001 cmsinst && adduser -u 1001 -g 1001 cmsinst && \
        install -d /opt && install -d -o cmsinst /opt/cms

# Make Images grid/singularity compatible
RUN mkdir -p /cvmfs /afs /eos /opt/cms

# Add a couple of useful files to cmsusr account
WORKDIR /home/cmsusr
USER cmsusr
ENV USER cmsusr
ENV HOME /home/cmsusr

ADD dot-pythonrc.py $HOME/.pythonrc.py
ADD dot-bashrc      $HOME/.bashrc
ADD dot-bashrc      $HOME/.zshrc

ADD     entrypoint.sh /opt/cms/entrypoint.sh
RUN     sudo chmod 755 /opt/cms/entrypoint.sh

ENTRYPOINT ["/opt/cms/entrypoint.sh"]
CMD     ["/bin/zsh"]
