#!/bin/bash
# For large version update
# Usage: ./script file.zip
# Author by liu 2017-07-04

PWD=`pwd`
WEB_URL="/data/isonev45"
FILE="$1"
IP=`ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'  `

if [ -z $1 ];then
	echo -e "\033[31mError,Please Usage: $0 web-xxxx.zip\033[0m"
	exit
fi

# 判断大版本zip包是否存在
if [ ! -f "$WEB_URL/$1" ];then
	#echo -e "\033[31m===================\033[0m"
	echo -e "\033[31mError,No such file!\033[0m"
	#echo -e "\033[31m===================\033[0m"
	exit
fi

# 创建大版本更新web目录
function mkdir_web ()
{
	if [ -d $WEB_URL/new_web ];then
		echo -e "\033[31m[new_web]directory is exist ,please delete.\033[0m"
		exit
	else
		mkdir $WEB_URL/new_web
	fi
}

# 解压大版本更新包
function unzip_web ()
{
	file=`echo $FILE |awk -F[.] '{print $2}'`
	if [ $file == zip ];then
		unzip $WEB_URL/$FILE -d $WEB_URL/new_web
		#echo "zip"
	elif [ $file == tar ];then
		tar zxvf $WEB_URL/$FILE -C $WEB_URL/new_web
		#echo "tar"
	else
		echo -e "\033[32mError,There are no file types\033[0m"
	fi
	#unzip $1 -d new_web
}

#删除旧配置文件
NEW_CONF_DIR="$WEB_URL/new_web/WEB-INF/classes"
function del_conf ()
{
	#NEW_CONF_DIR="$WEB_URL/new_web/WEB-INF/classes"
	cd $NEW_CONF_DIR && rm -rf *.conf pigeonTags.properties pigeon.lic && cd .. && \
	rm -rf Is1AppMarketContext.xml sessionContext.xml fulltextsearch.xml crontab.xml pigeonContext.xml IsoneSaasEngine.xml web.xml crontab_empty.xml IsoneJobsContext.xml
}

# 拷贝现有配置文件
function copy_conf ()
{
	CONF_DIR="$WEB_URL/web/WEB-INF/classes"
	cp $CONF_DIR/*.conf $NEW_CONF_DIR;
	cp $CONF_DIR/pigeon.lic $NEW_CONF_DIR;
	cp $CONF_DIR/pigeonTags.properties $NEW_CONF_DIR;
	cd $CONF_DIR/.. && cp Is1AppMarketContext.xml sessionContext.xml fulltextsearch.xml crontab.xml pigeonContext.xml IsoneSaasEngine.xml web.xml IsoneJobsContext.xml $WEB_URL/new_web/WEB-INF/.

}

# 关闭tomcat
function stop_tomcat ()
{
	PID=`ps -ef | grep java|grep isonev45|awk '{print $2}'`
	kill -9 $PID
}

# 备份原web并升级web
DATE=`date +%Y%m%d`
function install_web ()
{
	cd $WEB_URL;
	mv web web$DATE;
	mv new_web web
}

# 启动tomcat
function start_tomcat()
{
	$WEB_URL/apache-tomcat-7.0.32/bin/startup.sh
}

# 启动函数，更新
mkdir_web
unzip_web
del_conf
copy_conf
stop_tomcat
install_web
start_tomcat
if [ $? -eq 0 ];then
	echo
        echo -e "\033[32m成功启动tomcat，请访问 http://$IP 测试\033[0m"
	echo
fi
