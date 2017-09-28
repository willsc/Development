#!/bin/bash

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


umount /proc || umount -lf /proc
umount /sys
umount /dev/pts
exit
umount edit/dev




