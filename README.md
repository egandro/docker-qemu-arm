# docker-qemu-arm

Run Docker x86_64 on Arm computers or Android

Original idea: <https://gist.github.com/oofnikj/e79aef095cd08756f7f26ed244355d62>

This is a automatic installation script.


## Android Phone/Tablet with Termux


```bash
$ curl -o termux-setup.sh https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/termux-setup.sh && chmod 755 ./termux-setup.sh && ./termux-setup.sh
```


## Raspberry Pi


```bash
$ curl -o pi-setup.sh https://raw.githubusercontent.com/egandro/docker-qemu-arm/master/pi-setup.sh && chmod 755 ./termux-setup.sh && ./pi-setup.sh
```

## Postinstall & fun

- start the VM with "startqemu.sh"
- root passwort is "Secret123" but root in ssh is locked by password
- please change the password anyway
- you can ssh to the VM with a 2nd Terminal and "ssh2qemu.h" qemukey / qemukey.ssh are SSH keys
- run a "uname -a" and a "docker run hello-world"


## Thanks

- Thanks to everybody who made this happen.
