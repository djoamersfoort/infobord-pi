#!/bin/sh -e

install -v -o 1000 -g 1000 -m 0755 "files/infobord-controller.py" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"
install -v -o 1000 -g 1000 -m 0755 "files/x11login" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"
install -v -o 1000 -g 1000 -m 0644 "files/.xinitrc" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"
install -v -o 1000 -g 1000 -m 0644 "files/.profile" "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"

install -v -m 0644 "files/x11.service" "${ROOTFS_DIR}/etc/systemd/system/"
install -v -m 0644 "files/config.txt" "${ROOTFS_DIR}/boot/config.txt"
