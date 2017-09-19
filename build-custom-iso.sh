#!/bin/bash

cd /root/custom-img
chmod +w extract/install/filesystem.manifest
root edit dpkg-query -W --showformat='${Package} ${Version}\n' | sudo tee extract/install/filesystem.manifest


mksquashfs edit extract/install/filesystem.squashfs -b 1048576
printf $(sudo du -sx --block-size=1 edit | cut -f1) | sudo tee extract/install/filesystem.size


cd extract; rm md5sum.txt
find -type f -print0 | sudo xargs -0 md5sum | grep -v isolinux/boot.cat | sudo tee md5sum.txt



genisoimage -D -r -V "$IMAGE_NAME" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../ubuntu-16.04.3.SLbuild.`date +%Y%m%d%H%M%S`.iso .


