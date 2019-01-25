#!/bin/bash
#

set -e

sudo modprobe binfmt_misc
cp -rv stage-infobord pi-gen/
cp config pi-gen/
touch pi-gen/stage2/SKIP_IMAGES

cd pi-gen
./build-docker.sh
