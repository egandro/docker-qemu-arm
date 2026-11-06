#!/data/data/com.termux/files/usr/bin/bash

pkg update
pkg install -y expect curl qemu-utils qemu-common qemu-system-x86_64-headless openssh


CONFIG_FILE="${CONFIG_FILE:-config.env}"
if [ ! -f "$CONFIG_FILE" ]; then
    # get the default config file
    cp config.sample "$CONFIG_FILE"
fi

# shellcheck disable=SC1090
source "$CONFIG_FILE"

expect -f installqemu.expect

echo "to start your new vm:"
echo "  cd \$INSTALLATION_DIR && ./startqemu.sh"

