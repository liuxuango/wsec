#!/bin/bash
# Get sql time and send open-falcon
# Author Liu 2017-06-19

PWD="/data/pigeon/mall/PigeonServer/logs"

TIME=`tail -1 $PWD/stdout.log | awk '{print $10}' |sed 's/time://g'|sed 's/ms,//g'`

HOSTNAME=$HOSTNAME
DATE=`date '+%s'`

curl -X POST -d '[{"metric": "sql.time", "endpoint": "'$HOSTNAME'", "timestamp": '$DATE', "step": 60,"value": '$TIME',"counterType": "GAUGE","tags": ""}]' http://127.0.0.1:1988/v1/push
