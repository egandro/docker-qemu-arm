#!/data/data/com.termux/files/usr/bin/bash

pkg update
pkg install -y expect curl qemu-utils qemu-common qemu-system-x86_64-headless openssh


if [ ! -f "config.env" ]; then
    # get the default config file
    cp config.sample config.env
fi

source config.env

expect -f installqemu.expect

echo "to start your new vm:"
echo "  cd \$INSTALLATION_DIR && ./startqemu.sh"

