#!/bin/bash


apt-get -y install squashfs-tools genisoimage mkisofs


# Create custom image directory


IMGDIR=/root/custom-img
ISO=/root/ubuntu-16.04.3-server-amd64.iso
RESOLVER=/etc/resolv.conf

if [ ! -d "$IMGDIR" ]; then
   mkdir /root/custom-img

 fi

cp ${ISO} ${IMGDIR}
cd ${IMGDIR}; mkdir mnt; mount -o loop ${ISO} mnt

mkdir extract
rsync --exclude=/install/filesystem.squashfs -a mnt/ extract


unsquashfs mnt/install/filesystem.squashfs;mv squashfs-root edit
cp ${RESOLVER} edit/etc/



mount --bind /dev/ edit/dev
chroot edit
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devpts none /dev/pts

export HOME=/root
export LC_ALL=C
dbus-uuidgen > /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl


dpkg --add-architecture i386; apt-get update && apt-get upgrade
apt-get -y install linux-tools crash 

apt-get autoremove && apt-get autoclean
rm -rf /tmp/* ~/.bash_history
rm /var/lib/dbus/machine-id
rm /sbin/initctl
dpkg-divert --rename --remove /sbin/initctl






