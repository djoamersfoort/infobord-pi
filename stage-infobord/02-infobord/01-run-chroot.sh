#!/bin/sh

/bin/systemctl enable x11

pip3 install paho-mqtt

# Lock user, only allow SSH key access
usermod -L "${FIRST_USER_NAME}"
