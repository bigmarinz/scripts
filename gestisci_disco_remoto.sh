#!/bin/bash
#
# Daniele Marinello <marinz at email dot it>
#
# Monta una partizione remota

# user settings:
IP="192.168.0.3"
risorsa="/media/stainer"
filesystem="nfs4"

#
# don't edit:
#
mtab_r="$(grep $risorsa /etc/mtab)"
mount_cmd="sudo mount -t $filesystem $IP:/ $risorsa"
umount_cmd="sudo umount $risorsa"

if [ "$mtab_r" == "" ]; then
	$mount_cmd
else
	$umount_cmd
fi	
