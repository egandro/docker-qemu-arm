#!/data/data/com.termux/files/usr/bin/bash 

# Define os caminhos absolutos para evitar erros de diretório
INSTALLATION_DIR="$HOME/alpine-arm"
BIOS="$INSTALLATION_DIR/BIOS/QEMU_EFI.fd"
DRIVE="$INSTALLATION_DIR/DRIVE/alpine-docker.qcow2"

echo "🚀 Iniciando Alpine Linux (Docker) no QEMU..."
echo "🔌 SSH: porta 8822 | 🌐 Web: porta 7300"
echo "Para sair do QEMU, pressione: Ctrl+A e depois X"
echo "-------------------------------------------------"

qemu-system-aarch64 -machine virt -m 2048 -smp cpus=2 -cpu cortex-a57 \
    -bios "$BIOS" \
    -nic user,id=n1,hostfwd=tcp::8822-:22,hostfwd=tcp::7300-:3000 \
    -drive file="$DRIVE",format=qcow2,if=virtio \
    -nographic