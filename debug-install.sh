#!/bin/bash

if [ -n "${TERMUX_VERSION:-}" ] && [ "${ALLOW_TERMUX:-0}" != "1" ]; then
  echo "Error: This won't run on Termux"
  exit 1
fi

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
