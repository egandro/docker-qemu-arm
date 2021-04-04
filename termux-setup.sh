pkg install -y expect wget qemu-utils qemu-common qemu-system-x86_64-headless
mkdir -p alpine
cd alpine
wget -q -c -t0 https://github.com/egandro/docker-qemu-arm/ssh2qemu.sh
chmod +x ./ssh2qemu.sh
wget -q -c -t0 https://github.com/egandro/docker-qemu-arm/startqemu.sh
chmod +x ./startqemu.sh
wget -q -c -t0 https://github.com/egandro/docker-qemu-arm/installqemu.expect
