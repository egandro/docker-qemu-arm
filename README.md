# docker-qemu-arm

Run Docker x86_64 on Android Tablets or Phones

Original idea: <https://gist.github.com/oofnikj/e79aef095cd08756f7f26ed244355d62>

This is a automatic installation script. As RAM is always an issue on a cell phone, we also install zram.

Check the [Changes](CHANGELOG.md).

## Android Phone/Tablet with Termux

- Learn about wake locks in Termux: <https://wiki.termux.com/wiki/Termux-wake-lock>

### Quick Install

```bash
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/termux-setup.sh)"
# WARNING: change your alpine root passwort (or run the custom installer if you want to start with a custom password)
```

### Custom Install

```bash
$ pkg update
$ pkg upgrade
$ pkg install git
$ git clone https://github.com/egandro/docker-qemu-arm.git
$ cd docker-qemu-arm
$ cp config.sample config.env
$ # vi config.env # change everything you want to need to change
$ ./install.sh
```

### Run

```bash
$ cd $HOME/alpine
$ ./startqemu.sh
```

## Development build of this repo in Docker

This runs this repository in a reproducible Termux container, so the installer
can be built and tested without an Android device. The container already
includes QEMU, the UEFI firmware and all build dependencies, and uses the
existing `debug-install.sh`:

```bash
$ ./dev/run.sh build
$ ./dev/run.sh install
$ ./dev/run.sh start
```

See [dev/README.md](dev/README.md) for details and the other commands.

## Postinstall & fun

- you can ssh to the VM with a 2nd Terminal and `ssh2qemu.sh` qemukey / qemukey.ssh are the generated SSH keys
- run a `uname -a` and a `docker run hello-world`

## Thanks

- Thanks to everybody who made this happen.

## Known Issues / Hacks / Warnings

- Termux easily gets outdated very quickly! Sometimes packages dependencies or mirrors are broken.
- If you don't have the skills to properly fix this you might want to backup your data, uninstall and reinstall Termux.
- Sometimes the Alpine Linux Mirrors are broken. Delete the `alpine.img` file and retry the installation.
- Alpine Linux & dns & ipv4 only vs ipv4/6 is (very often) broken.
- Mitigation: the script turns off ipv6 and set the dns to `8.8.8.8` (can be changed).

## SSHHole

> [!IMPORTANT]
> If you are using a previous version (lower than Alpine 3.24), ssh into the VM (`./ssh2qemu.sh`) and run `apk upgrade openssh`.
> Alpine 3.21 and older are EOL but have a patch. Alpine 3.15 and older are not patched — please upgrade.
>
> Check whether your installation is affected ([sshhole.com](https://sshhole.com/), [check.sh](https://github.com/oz9un/sshole)):
>
> ```sh
> cd $HOME/alpine
> ./startqemu.sh
> # wait for aline to be booted && open a new terminal
> cd $HOME/alpine
> ./startqemu.sh
> # in alpine
> wget https://raw.githubusercontent.com/oz9un/sshole/main/check.sh
> cat check.sh
> sh check.sh
> ```
