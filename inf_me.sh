# !/bin/bash
# 
# <m2346zc5-github@yahoo.it>
#
# a crontab script
# required: nbsmtp vnstat (check user permission or use this script as root)
#

# edit settings:
interface="wlan0"
from="m2346zc5-github@yahoo.it"
to="m2346zc5-github@yahoo.it"
subject="report"
smtpserver="smtp.email.it"

# if you want use smtp-auth, set these parameters: 
smtplogin="user"
smtppass="password"

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

