#!/usr/bin/env bash
set -euo pipefail

DEV_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd -- "$DEV_DIR/.." && pwd)"

IMAGE="${DOCKER_QEMU_ARM_IMAGE:-docker-qemu-arm-dev}"
TERMUX_IMAGE="${TERMUX_DOCKER_IMAGE:-termux/termux-docker:latest}"
CONTAINER="${DOCKER_QEMU_ARM_CONTAINER:-docker-qemu-arm-dev}"
VOLUME="${DOCKER_QEMU_ARM_VOLUME:-docker-qemu-arm-dev-home}"
SSH_PORT="${SSH_PORT:-2222}"
CONTAINER_HOME="/data/data/com.termux/files/home"

usage() {
    cat <<EOF
Usage: ${0##*/} [command]

Commands:
  shell (default)  interactive Termux shell in the dev container
  install          create/install the Alpine VM (runs debug-install.sh)
  start            boot the installed VM (startqemu.sh)
  ssh              ssh into the running VM from another terminal
  key              print the generated VM ssh private key
  build [args...]  build/update the dev image
  <command...>     run an arbitrary command in the container

Environment:
  SSH_PORT                 host port forwarded to the VM sshd (default: 2222)
  DOCKER_QEMU_ARM_IMAGE    dev image name (default: docker-qemu-arm-dev)
  DOCKER_QEMU_ARM_VOLUME   home volume name (default: docker-qemu-arm-dev-home)
  TERMUX_DOCKER_IMAGE      base image (default: termux/termux-docker:latest)
EOF
}

build() {
    docker build \
        --build-arg "TERMUX_DOCKER_IMAGE=$TERMUX_IMAGE" \
        "$@" \
        -t "$IMAGE" \
        "$DEV_DIR"
}

ensure_image() {
    if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
        build
    fi
}

docker_run() {
    local publish=()
    local tty=()
    if [ "${PUBLISH_SSH:-0}" = "1" ]; then
        publish=(--name "$CONTAINER" --publish "${SSH_PORT}:2222")
    fi
    if [ -t 0 ] && [ -t 1 ]; then
        tty=(-t)
    fi

    docker run --rm -i "${tty[@]}" \
        --security-opt seccomp=unconfined \
        "${publish[@]}" \
        --workdir /workspace \
        --volume "$REPO_DIR:/workspace" \
        --volume "$VOLUME:$CONTAINER_HOME" \
        "$IMAGE" \
        /workspace/dev/entrypoint.sh "$@"
}

docker_run_once() {
    docker run --rm -i \
        --workdir /workspace \
        --volume "$REPO_DIR:/workspace" \
        --volume "$VOLUME:$CONTAINER_HOME" \
        "$IMAGE" \
        /workspace/dev/entrypoint.sh "$@"
}

case "${1:-shell}" in
    -h|--help|help)
        usage
        ;;
    build)
        shift
        build "$@"
        ;;
    shell)
        shift || true
        ensure_image
        docker_run shell "$@"
        ;;
    install|debug)
        shift || true
        ensure_image
        docker_run install "$@"
        ;;
    start)
        shift || true
        ensure_image
        if [ -n "$(docker ps -q --filter "name=^${CONTAINER}$")" ]; then
            echo "error: container '$CONTAINER' is already running" >&2
            exit 1
        fi
        PUBLISH_SSH=1 docker_run start "$@"
        ;;
    ssh)
        if [ -z "$(docker ps -q --filter "name=^${CONTAINER}$")" ]; then
            echo "error: container '$CONTAINER' is not running; start the VM first" >&2
            exit 1
        fi
        docker exec -it "$CONTAINER" /workspace/dev/entrypoint.sh ssh
        ;;
    key)
        ensure_image
        docker_run_once key
        ;;
    *)
        ensure_image
        docker_run "$@"
        ;;
esac
