#!/bin/bash
#Script to run QEMU for buildroot as the default configuration qemu_aarch64_virt_defconfig
#Host forwarding: Host Port 10022 ->> QEMU Port 22 
#Author: Siddhant Jajoo.

# Debug Cparadis: try some options trying to debug qemu-system-aarch64 instance
#    -bios none \
#
# Error #1: Getting this error even with 'buildroot/configs/qemu_aarch64_virt_defconfig'
#   rom: requested regions overlap (rom bootloader. free=0x0000000040a51a00, addr=0x0000000040000000)
#   qemu-system-aarch64: rom check and register reset failed
#
#       ===> May need to try VM Ubuntu v20.04
#
# QEMU port forwarding:
# "hostfwd=tcp::HOSTPORT-:GUESTPORT"

qemu-system-aarch64 \
    -M virt  \
    -cpu cortex-a53 -nographic -smp 1 \
    -kernel buildroot/output/images/Image \
    -append "rootwait root=/dev/vda console=ttyAMA0" \
    -netdev user,id=eth0,hostfwd=tcp::10022-:22,hostfwd=tcp::9000-:9000 \
    -device virtio-net-device,netdev=eth0 \
    -drive file=buildroot/output/images/rootfs.ext4,if=none,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 -device virtio-rng-pci
