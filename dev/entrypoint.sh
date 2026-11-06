#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

# The repository is bind-mounted here by dev/run.sh.
REPO_DIR="/workspace"
CONTAINER_HOME="/data/data/com.termux/files/home"

# Keep all generated files (config, ISO, disk image and SSH key) in the
# container's home directory, which is backed by a persistent volume.
export CONFIG_FILE="${CONFIG_FILE:-$CONTAINER_HOME/config.env}"
export ALLOW_TERMUX=1

if [ ! -f "$CONFIG_FILE" ]; then
    if [ ! -f "$REPO_DIR/config.sample" ]; then
        echo "error: neither $CONFIG_FILE nor $REPO_DIR/config.sample exists" >&2
        exit 1
    fi
    cp "$REPO_DIR/config.sample" "$CONFIG_FILE"
    echo "Created $CONFIG_FILE from config.sample"
fi

# shellcheck disable=SC1090
source "$CONFIG_FILE"

case "${1:-shell}" in
    shell)
        cd "$REPO_DIR"
        exec bash -l
        ;;
    install|debug)
        cd "$REPO_DIR"
        exec bash ./debug-install.sh
        ;;
    start)
        cd "$INSTALLATION_DIR"
        exec bash ./startqemu.sh
        ;;
    ssh)
        cd "$INSTALLATION_DIR"
        exec bash ./ssh2qemu.sh
        ;;
    key)
        cat "$INSTALLATION_DIR/qemukey"
        ;;
    *)
        exec "$@"
        ;;
esac
