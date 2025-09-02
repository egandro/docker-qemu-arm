#!/bin/bash

if [ -n "$TERMUX_VERSION" ]; then
  echo "Error: This won't run on Termux"
  exit 1
fi

if [ ! -f "config.env" ]; then
    # get the default config file
    cp config.sample config.env
fi

source config.env

expect -f installqemu.expect

echo "to start your new vm:"
echo "  cd \$INSTALLATION_DIR && ./startqemu.sh"
