#!/bin/bash
# Check the backup status and send it to WeChat
# Author by liu 2017-06-05

DAY=`date +%-d`
MONTH=`date +%-m`
WEB16=`ls -l web16.tar.gz | awk '{print $7}'`
WEB5=`ls -l web5.tar.gz | awk '{print $7}'`
ERP=`ls -l erp.tar.gz | awk '{print $7}'`
ORACLE=`ls -l oracle.tar.gz | awk '{print $7}'`
ORACLE2=`ls -l oracle2.tar.gz | awk '{print $7}'`

function web16 ()
{
	if [ $DAY -eq $WEB16 ];then
		echo "web16服务器备份成功！"
	else
		echo "【error】web16服务器备份失败，请检查！"
	fi
}

function web5 ()
{
	if [ $DAY -eq $WEB5 ];then
		echo "web5服务器备份成功！"
        else
                echo "【error】web5服务器备份失败，请检查！"
        fi
}

function erp ()
{
        if [ $DAY -eq $ERP ];then
                echo "erp服务器备份成功！"
        else
                echo "【error】erp服务器备份失败，请检查！"
        fi
}

function oracle ()
{
        if [ $DAY -eq $ORACLE ];then
                echo "oracle服务器备份成功！"
	elif [ $DAY -eq $ORACLE2 ];then
		echo "oracle服务器备份成功！"
        else
                echo "【error】oracle服务器备份失败，请检查！"
        fi
}

web16=`web16`
web5=`web5`
function message ()
{
	echo -e "$web16\n$web5"
}
#echo -e "`message`"
#curl http://128.0.1.110:4567/send -d tos=809879580 -d content=`message`
curl http://128.0.1.110:4567/send -d tos=809879580 -d content=【$MONTH月$DAY日】\n`web16``web5``erp``oracle`
