#!/bin/bash
#

set -e

# Do this before running this:
#
# apt install docker.io
# Add your account to the docker group (usermod -aG docker <username>) and re-login
# git submodule init
# git submodule update
# cp config.ex config
# edit config to suit your needs (wifi ssid/password)
# ./build.sh
# Image will be in pi-gen/deploy/

sudo modprobe binfmt_misc
cp -rv stage-infobord pi-gen/
cp config pi-gen/
touch pi-gen/stage2/SKIP_IMAGES

cd pi-gen
cat ../fix.patch | patch -p0 -N || true
./build-docker.sh

# Cleanup
cat ../fix.patch | patch -p0 -R
rm -rf stage-infobord/
