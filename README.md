# docker-qemu-arm

Run Docker x86_64 on Android Tablets or Phones

Original idea: <https://gist.github.com/oofnikj/e79aef095cd08756f7f26ed244355d62>

This is a automatic installation script. As RAM is always an issue on a cell phone, we also install zram.


## Android Phone/Tablet with Termux

- Learn about wake locks in Termux: <https://wiki.termux.com/wiki/Termux-wake-lock>

### Quick Install

```bash
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/termux-setup.sh)"
# change you alpine root passwort or run the custom installer!
```

### Custom Install

```bash
$ pkg update
$ pkg install git
$ git clone https://github.com/egandro/docker-qemu-arm.git
$ cd docker-qemu-arm
$ cp config.sample config.env
$ # vi config.env # change everything you want to need to change
$ ./install.sh
```

### Run

```bash
$ $HOME/alpine
$ ./startqemu.sh
```

## Known issues

- Alpine Linux & dns & ipv4 only vs ipv4/6 is (very often) broken. We pin the dns to `8.8.8.8` (can be changed) and in Alpine we turn off ipv6. 

## Postinstall & fun

- you can ssh to the VM with a 2nd Terminal and `ssh2qemu.sh` qemukey / qemukey.ssh are the generated SSH keys
- run a `uname -a` and a `docker run hello-world`

## Thanks

- Thanks to everybody who made this happen.

## Changelog

### 2024/04/26

- added customizable installer (git checkout)
- updated to latest Alpine 3.19

### 2021/10/07

- added config.env - this makes it much simpler for developers to tweak version numbers
- fixed issue with alpine for zram
- updated to alpine-virt-3.14.0-x86_64.iso

