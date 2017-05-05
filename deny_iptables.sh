#!/bin/bash
# Deny access, if include phone_validateCode_handler.jsp
# Author by liu 2017-05-05

IPS=`tail -n 100000 /data/httpd-2.4.17/logs/www.xxx.com-access_log | grep phone_validateCode_handler.jsp |awk '{print $1}' |sort |uniq -c |sort -nr | awk '$1>=10 {print $2}'`

#IPTABLES_CONF=/etc/sysconfig/iptables

for ip in $IPS
do
        iptables -I INPUT -s $ip -j DROP
done
