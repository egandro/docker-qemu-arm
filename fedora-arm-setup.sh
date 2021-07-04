#!/bin/bash

sudo dnf install -y qemu-system-x86-core edk2-ovmf expect wget

mkdir -p alpine
cd alpine
wget -q -c -t0 https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/ssh2qemu.sh
chmod +x ./ssh2qemu.sh
wget -q -c -t0 https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/startqemu.sh
chmod +x ./startqemu.sh
sed -i "s:\$PREFIX/share/qemu/edk2-x86_64-code.fd:/usr/share/edk2/ovmf/OVMF_CODE.fd:g" ./startqemu.sh
wget -q -c -t0 https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/installqemu.expect
sed -i "s:\$env(PREFIX)/share/qemu/edk2-x86_64-code.fd:/usr/share/edk2/ovmf/OVMF_CODE.fd:g" ./installqemu.expect
expect -f installqemu.expect
