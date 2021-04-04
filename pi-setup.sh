#!/bin/bash

# we need qemu 5.2+

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC

rm -f /etc/apt/sources.list.d/buster-backports.list
echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list.d/buster-backports.list

sudo apt-get update

sudo apt-get install -y wget expect
sudo apt-get -t buster-backports install -y qemu qemu-system-common qemu-system-data qemu-system-x86 qemu-utils

mkdir -p alpine
cd alpine
wget -q -c -t0 https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/ssh2qemu.sh
chmod +x ./ssh2qemu.sh
wget -q -c -t0 https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/startqemu.sh
chmod +x ./startqemu.sh
wget -q -c -t0 https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/installqemu.expect
export PREFIX=""
expect -f installqemu.expect
