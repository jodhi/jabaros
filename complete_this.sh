#!/bin/bash
sudo rm extract/live/filesystem.squashfs
 sudo umount edit/dev
sudo chmod +w extract/live/filesystem.packages
sudo chroot edit dpkg-query -W --showformat='${Package} ${Version}\n' | sudo tee extract/live/filesystem.packages
sudo cp extract/live/filesystem.packages extract/live/filesystem.manifest-desktop
sudo mksquashfs edit extract/live/filesystem.squashfs -b 1048576 -no-duplicates
printf $(sudo du -sx --block-size=1 edit | cut -f1) | sudo tee extract/live/filesystem.size
cd extract
 sudo rm md5sum.txt
find -type f -print0 | sudo xargs -0 md5sum | grep -v isolinux/boot.cat | sudo tee md5sum.txt
sudo genisoimage -D -r -V "$IMAGE_NAME" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../name-of-your-.iso .
mv  ../name-of*iso /media/sf_cova
