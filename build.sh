#!/bin/bash
#

set -e

# Do this before running this:
#
# apt install docker.io
# Add your account to the docker group (usermod -aG docker <username>) and re-login
# git submodule init
# git submodule update

sudo modprobe binfmt_misc
cp -rv stage-infobord pi-gen/
cp config pi-gen/
touch pi-gen/stage2/SKIP_IMAGES

cd pi-gen
./build-docker.sh
