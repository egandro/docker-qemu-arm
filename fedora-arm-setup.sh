#!/bin/bash

export URL=https://raw.githubusercontent.com/egandro/docker-qemu-arm
export BRANCH=master

sudo dnf install -y qemu-system-x86-core edk2-ovmf expect wget

mkdir -p alpine
cd alpine

if [ ! -f "config.env" ]; then
    # get the default config file
    wget -q -c -t0 ${URL}/${BRANCH}/config.env
fi

# URL / BRANCH might be overwritten here
. config.env

wget -q -c -t0 ${URL}/${BRANCH}/answerfile
wget -q -c -t0 ${URL}/${BRANCH}/ssh2qemu.sh
chmod +x ./ssh2qemu.sh
wget -q -c -t0 ${URL}/${BRANCH}/startqemu.sh
chmod +x ./startqemu.sh
sed -i "s:\$PREFIX/share/qemu/edk2-x86_64-code.fd:/usr/share/edk2/ovmf/OVMF_CODE.fd:g" ./startqemu.sh
wget -q -c -t0 ${URL}/${BRANCH}/installqemu.expect
sed -i "s:\$env(PREFIX)/share/qemu/edk2-x86_64-code.fd:/usr/share/edk2/ovmf/OVMF_CODE.fd:g" ./installqemu.expect
expect -f installqemu.expect
