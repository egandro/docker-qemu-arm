# docker-qemu-arm

Run Docker x86_64 on Arm computers or Android

Original idea: <https://gist.github.com/oofnikj/e79aef095cd08756f7f26ed244355d62>

This is a automatic installation script. As memory is always short, we also install zram.


## Android Phone/Tablet with Termux


```bash
$ curl -o termux-setup.sh https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/termux-setup.sh && chmod 755 ./termux-setup.sh && ./termux-setup.sh
```


## Raspberry Pi OS


```bash
$ curl -o pi-setup.sh https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/pi-setup.sh && chmod 755 ./pi-setup.sh && ./pi-setup.sh
```

##  Fedora ARM

```bash
$ curl -o fedora-arm-setup.sh https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/fedora-arm-setup.sh && chmod 755 ./fedora-arm-setup.sh && ./fedora-arm-setup.sh
```


## Postinstall & fun

- start the VM with "startqemu.sh"
- root passwort is "Secret123" but root in ssh is locked by password
- please change the password anyway
- you can ssh to the VM with a 2nd Terminal and "ssh2qemu.sh" qemukey / qemukey.ssh are SSH keys
- run a "uname -a" and a "docker run hello-world"

## Known issues

- kubernetes (which is a very stupid idea): cgroups in Alpine must be configured properly
- just in case you really want that here is how: <https://wiki.alpinelinux.org/wiki/Docker>

## Thanks

- Thanks to everybody who made this happen.

## Changelog
### 2021/10/07

- added config.env - this makes it much simpler for developers to tweak version numbers
- fixed issue with alpine for zram
- updated to alpine-virt-3.14.0-x86_64.iso


