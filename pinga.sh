#!/bin/bash
#
#
# <m2346zc5-github@yahoo.it>
# 
# crontab script
# Se riesce a pingare un IP della lan, esegue un azione
# Se non pinga, ne esegue un altra
#
# richiede il file "ping_lanIP" in /home contenente gli IP dei pc

c=0;
pc=0;
for IP in $(cat ping_lanIP)
do
	let "pc+=1";
	ping -c 1 $IP > /dev/null 2>&1
	if [ $? -eq 0 ] ; then 		# IP è pingabile
		
		if [ -f /tmp/pinga_stop ]; then
			echo 
		else
			./stop
			touch /tmp/pinga_stop
		fi
		
		if [ -f /tmp/pinga_start ]; then
			rm /tmp/pinga_start
		fi
	else
		let "c+=1";
	fi	
done

	if [ -f /tmp/pinga_start ]; then
        	echo
	elif [ "$c" -eq "$pc" ]; then	# nessun IP è pingabile
		
		./go
		touch /tmp/pinga_start
		
		if [ -f /tmp/pinga_stop ]; then
			rm /tmp/pinga_stop
		fi
	fi
