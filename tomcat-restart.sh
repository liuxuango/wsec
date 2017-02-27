#!/bin/sh
# restart tomcat of test server

check_tomcat='ps -fe|grep java |grep -v grep'

stop_tomcat() {
    killall java
}

start_tomcat() {
    cd /data/isonev45/mall/apache-tomcat-7.0.32/bin/
    ./startup.sh
    cd /data/isonev45/mall/PigeonServer/bin/
    ./start.sh 
    cd /data/isonev45/discovery/apache-tomcat-7.0.32/bin/
    ./startup.sh 
    cd /data/isonev45/CardReport/apache-tomcat-7.0.32/bin
    ./startup.sh
    cd /data/isonev45/frontMachine/apache-tomcat-7.0.32/bin
    ./startup.sh
}

print_restarted() {
    echo "========Restart Tomcat service is done========"
}

print_started() {
    echo "========Start Tomcat service is done========"
}

if [ "$check_tomcat" != "" ]; then
    stop_tomcat
    start_tomcat
    print_restarted
else
    start_tomcat
    print_started
fi
