# cmssw-docker
Dockerfiles for CMSSW

There are two different sets of Dockerfiles in this repository:
- [CVMFS](cvmfs)-based images
- [standalone](standalone) images
The former will need the CMS instance of CVMFS mounted. The advantage is that they are much smaller while the standalone images contain the full CMSSW release (around 15 GB).

# Building containers

Change to the directory containing the Dockerfiles and execute one of the following commands (examples are given for different `CMSSW_VERSION` and `SCRAM_ARCH`). Mind that the `.` at the end is important:

Production releases:

```
docker build -f Dockerfile_production \
            -t cmssw:9_2_1 \
            --build-arg CMSSW_VERSION=CMSSW_9_2_1 \
            --build-arg SCRAM_ARCH=slc6_amd64_gcc530 \
            .
```

Patch releases:

```
docker build -f Dockerfile_patch \
            -t cmssw:7_1_25_patch5 \
            --build-arg CMSSW_VERSION=CMSSW_7_1_25 \
            --build-arg SCRAM_ARCH=slc6_amd64_gcc481 \
            --build-arg PATCH=patch5 \
            .
```

# Running containers

Currently supported for automatic CMSSW setup are `bash` and `zshrc`.

`bash`:
```
docker run -it --rm cmssw:9_2_1 /bin/bash
```
`zsh`:
```
docker run -it --rm cmssw:9_2_1 /bin/zsh
```

## Grid proxy

If you would like to be able to get a voms/grid proxy, mount your `.globus` directory by adding `-v ~/.globus:/home/cmsbld/.globus` to your `docker run` command.
