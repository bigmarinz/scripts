#!/bin/bash
#
# <m2346zc5-github@yahoo.it>
#
# Monta una partizione remota

# user settings:
IP="192.168.0.3"
risorsa="/media/risorsa"
filesystem="nfs4"

#
mtab_r="$(grep $risorsa /etc/mtab)"
mount_cmd="sudo mount -t $filesystem $IP:/ $risorsa"
umount_cmd="sudo umount $risorsa"

if [ "$mtab_r" == "" ]; then
	$mount_cmd
else
	$umount_cmd
fi	
