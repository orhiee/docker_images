#! /bin/bash

### before you start this script
# * create a folder in home directory like "docker_zeek_arm64"
# * enter directory
# * make sure you have "Dockerfile" and "run.sh" in the directory



# clone the latest version of zeek from github:
## this is the latest DEV build.
## --recursive is a must, 532 mb with recursive
git clone --recursive https://github.com/zeek/zeek

## get version number from latest git
git_version=$(head -1 ./zeek/CHANGES | cut -d " " -f 1)

## add version info to build
build_command="docker build -t  zeek_arm64_dev:$git_version ."

## start build.
echo ""
echo "Starting docker build"
echo "..."
echo ""
sudo $build_command