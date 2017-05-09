#!/bin/bash
# Auto mass transfer files
# Author by liu 2017-05-09

if [ ! -f ip.txt ];then
        echo -e "\033[31mError, Please first mkdir ip.txt!\033[0m"
        exit
fi

if [ -z $1 ];then
        echo -e "\033[31mErrot, Please Usage: $0 cmmand, Example{Src_Files|Src_Dir Des_dir} \033[0m"
        exit
fi

line_num=`cat ip.txt | wc -l`
rm -rf ip.txt.swp
i=0
while ((i<$line_num))
do
        i=`expr $i + 1`
        sed "${i}s/^/&${i} /g" ip.txt >>ip.txt.wsec
        IP=`awk -v I="$i" '{if(I==$1)print $2}' ip.txt.wsec`
        #echo $IP
        scp -r $1 root@${IP}:$2
        if [ $? -eq 0];then
                rm -rf ip.txt.wsec
        fi
done
