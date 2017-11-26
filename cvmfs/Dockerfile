##
## A container where CernVM-FS is up and running for CMSSW
FROM cern/slc6-base
LABEL maintainer="Clemens Lange clemens.lange@cern.ch"

USER root
ENV USER root
ENV HOME /root
ENV VO_CMS_SW_DIR       /cvmfs/cms.cern.ch
ENV CMS_LOCAL_ROOT_BASE /cvmfs/cms.cern.ch

## make sure FUSE can be enabled
RUN if [[ ! -e /dev/fuse ]]; then mknod -m 666 /dev/fuse c 10 229; fi

# install cvmfs repos
ADD etc-yum-cernvm.repo /etc/yum.repos.d/cernvm.repo

# Install rpms
RUN yum update -y && yum install -y \
    cvmfs cvmfs-auto-setup cvmfs-config-default \
	csh \
    freetype fuse \
    glibc-headers \
    man nano openssh-server openssl098e libXext libXpm \
	tcsh time \
	zsh \
    glibc-devel.i686 glibc-devel \
    ; \
    yum clean -y all

WORKDIR /root

ADD dot-pythonrc.py  $HOME/.pythonrc.py
ADD etc-cvmfs-default-local /etc/cvmfs/default.local
ADD etc-cvmfs-domain-local  /etc/cvmfs/domain.d/cern.ch.local
ADD etc-cvmfs-keys          /etc/cvmfs/keys
ADD dot-bashrc              $HOME/.bashrc
ADD run-cvmfs.sh /etc/cvmfs/run-cvmfs.sh

RUN chmod uga+rx /etc/cvmfs/run-cvmfs.sh

# now CMSSW
RUN mkdir -p /cvmfs/cms.cern.ch && \
    echo "cms.cern.ch /cvmfs/cms.cern.ch cvmfs defaults 0 0" >> /etc/fstab

RUN yum install -y -q wget git

# EOF

# to run:
# docker run --rm --privileged -it clelange/cvmfs-cmssw /bin/bash
## cmsrel CMSSW_9_3_2 && cd CMSSW_9_3_2/src && cmsenv
## git config --global user.name Clemens Lange && git config --global user.email clemens.lange@cern.ch && git config --global user.github clelange
## git cms-init -y
## git checkout official-cmssw/master -- .clang-tidy
## git clone https://github.com/CMS-HGCAL/reco-ntuples.git RecoNtuples
## scram b code-checks-all
## scram b distclean && scram b -j 8
## git cms-checkdeps -a
## scram b -j 8
##