# Development build of this repo in Docker

This directory contains a reproducible Termux-like environment for running and
testing this repository and its installer without an Android device.

The image is based on [`termux/termux-docker`](https://github.com/termux/termux-docker)
and already contains `expect`, `curl`, `qemu`, `qemu-img`, `openssh` and the
UEFI firmware used by `startqemu.sh`. The container therefore runs the existing
[`debug-install.sh`](../debug-install.sh) instead of installing packages again
via `install.sh`.

## Requirements

- Docker (or Podman with a Docker-compatible CLI)
- an internet connection
- enough disk space for the Alpine ISO and the VM disk image (a few hundred MB)

QEMU runs without KVM in the container, so installing and booting the VM is
noticeably slower than on a phone or a normal virtual machine.

## Usage

```bash
# Build the image (only needed once, or after changing the Dockerfile)
./dev/run.sh build

# Install Alpine inside the container
./dev/run.sh install

# Boot the installed VM and keep this terminal attached to the serial console
./dev/run.sh start

# In a second terminal: log into the running VM over SSH
./dev/run.sh ssh

# Interactive shell inside the container
./dev/run.sh shell
```

The default host SSH port is `2222`. If that port is already in use, set a
different one for `start`:

```bash
SSH_PORT=2223 ./dev/run.sh start
```

## Generated files and configuration

All generated files are kept in a Docker volume named
`docker-qemu-arm-dev-home`, mounted as the Termux home directory:

- `config.env` – created from [`config.sample`](../config.sample) on first use
- `alpine/alpine.iso` – downloaded installer ISO
- `alpine/alpine.img` – installed VM disk
- `alpine/qemukey`, `alpine/qemukey.pub` – generated SSH key pair

To change installer settings, edit `config.env` in the volume:

```bash
./dev/run.sh shell
vi "$HOME/config.env"
```

To start over, remove the container and the volume:

```bash
docker rm -f docker-qemu-arm-dev 2>/dev/null || true
docker volume rm docker-qemu-arm-dev-home
```

To print the SSH key generated for the VM (for example to use it from the host):

```bash
./dev/run.sh key > dev/qemukey
chmod 600 dev/qemukey
ssh -i dev/qemukey -p 2222 root@localhost
```

Note that `dev/qemukey` is covered by the existing `qemukey*` rule in
[`.gitignore`](../.gitignore).

## Files

| File | Purpose |
| --- | --- |
| `Dockerfile` | Termux image with the development dependencies preinstalled |
| `run.sh` | Host-side wrapper for building and running the container |
| `entrypoint.sh` | Container-side command dispatcher and config bootstrap |
