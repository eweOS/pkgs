#!/bin/bash

#======================================
# Greeting...
#--------------------------------------
echo "Configure image: [$kiwi_iname]..."

#======================================
# Copy kernel image
#--------------------------------------
cp /usr/lib/modules/*/vmlinux /boot/vmlinux

#======================================
# Enable virtio-net driver
#--------------------------------------
echo "virtio_net" >> /etc/modules

#======================================
# Enable init services
#--------------------------------------
ln -s ../modules /etc/dinit.d/boot.d
ln -s ../udhcpc /etc/dinit.d/boot.d

#======================================
# Change hostname and set password
#--------------------------------------
echo "eweos-img" > /etc/hostname
echo 'root:$1$ewe$gaySV0Ar7d0prQ/1fYOKu0' | chpasswd -e || true

#======================================
# Make initramfs and copy initrd.gz
#--------------------------------------
# mkinitramfs -o /boot

#======================================
# Fix boot bug
#--------------------------------------
sed -i 's/mount -n -t devtmpfs/#mount -n -t devtmpfs/g' /etc/dinit.d/early-filesystems.sh || true
