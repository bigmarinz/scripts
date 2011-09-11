# !/bin/bash
# 
# Daniele Marinello <marinz@email.it>
#
# a crontab script for muletto, v0.2
# required: nbsmtp vnstat (check user permission or use this script as root)
#

# edit settings:
interface="wlan0"
from="marinz@email.it"
to="marinz@email.it"
subject="resoconto stainer"
smtpserver="smtp.email.it"

# if you want use smtp-auth, set these parameters: 
smtplogin="marinz@email.it"
smtppass="888opwwnhe8cmr634bxs"

# user cmd:
uptime="$(uptime | cut -d" " -f5)"
s_log="$(du -hc /var/log)"
s_free="$(free -m)"
s_disk="$(df -h)"
vnstat -u -i $interface # update vnstat db
stats="$(vnstat)"

body="up: $uptime\n\n$stats\n\n$s_log\n\n$s_free\n\n$s_disk"

# --------------
# don't edit ---
#
if [ -f /tmp/mail ]; then
    rm /tmp/mail
fi

data=$(date +"%a %b %d %T %Z %Y")
echo -e "to: $to" >> /tmp/mail
echo -e "subject: $subject" >> /tmp/mail
echo "date: $data" >> /tmp/mail
echo -e "\n" >> /tmp/mail
echo -e "$body" >> /tmp/mail

if [ "$smtplogin" == "" ]; then
     nbsmtp -f $from -h $smtpserver -n < /tmp/mail 
else
     nbsmtp -f $from -h $smtpserver -Ml -U $smtplogin -P $smtppass -n < /tmp/mail
fi

rm /tmp/mail 

