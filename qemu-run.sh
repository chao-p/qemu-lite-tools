#!/bin/sh

QEMU_BIN=/usr/local/bin/qemu-system-x86_64
KERNEL=~/git/linux-stable/vmlinux
KERNEL_CMD="root=/dev/pmem0p3 panic=1 rw tsc=reliable no_timer_check noreplace-smp  init=/usr/lib/systemd/systemd rootfstype=ext4 rcupdate.rcu_expedited=1 reboot=t"

IMAGE=~/image/clear-8800-kvm.img
IMAGE_SIZE=$(stat -c%s "$IMAGE")

set -x
$QEMU_BIN  -machine pc-lite,accel=kvm,kernel_irqchip,nvdimm \
        -cpu host -m 1024,maxmem=20G,slots=2 -smp 6 \
        -kernel $KERNEL -append "$KERNEL_CMD" \
        -no-user-config -nodefaults \
        -object memory-backend-file,id=mem0,share,mem-path=$IMAGE,size=$IMAGE_SIZE -device nvdimm,memdev=mem0,id=nv0 \
        -device virtio-serial-pci,id=virtio-serial0 -chardev stdio,id=charconsole0 -device virtconsole,chardev=charconsole0,id=console0 -nographic

