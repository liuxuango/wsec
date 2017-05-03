#!/bin/bash
#Auto lnmp server
#Author by liu 2017

#Define Nginx Variable
NGINX_FILE=nginx-1.9.9.tar.gz
NGINX_NAME=nginx-1.9.9
NGINX_SRC=http://mirrors.sohu.com/nginx/

#Define Mysql Variable
MYSQL_FILE=mysql-5.6.35.tar.gz
MYSQL_NAME=mysql-5.6.35
MYSQL_SRC=http://mirrors.sohu.com/mysql/MySQL-5.6/

#Define PHP Variable
PHP_FILE=php-5.6.30.tar.gz
PHP_NAME=PHP-5.6.30
PHP_SRC=http://mirrors.sohu.com/php/

#Define Nginx function
function nginx_install ()
{
        wget -c $NGINX_SRC/$NGINX_FILE; tar -zxvf $NGINX_FILE; cd $NGINX_NAME; yum install -y pcre* openssl* gcc; ./configure --prefix=/usr/local/nginx
        if [ $? -eq 0 ];then
                echo -e "\033[32mThe Nginx server install success !\033[0m"
        fi
}

#Define Mysql function
function mysql_install ()
{
        wget -c $MYSQL_SRC/$MYSQL_FILE; tar -zxvf $MYSQL_FILE; cd $MYSQL_NAME; yum -y install ncurses-devel libtool openssl-devel gcc-c++; useradd -r -s /sbin/nologin mysql; mkdir -pv /usr/local/mysql/data; cmake \
        -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
        -DMYSQL_DATADIR=/usr/local/mysql/data/ \
        -DMYSQL_UNIX_ADDR=/usr/local/mysql/mysql.sock \
        -DWITH_INNOBASE_STORAGE_ENGINE=1 \
        -DEXTRA_CHARSETS=all \
        -DDEFAULT_CHARSET=utf8 \
        -DDEFAULT_COLLATION=utf8_general_ci \
        -DWITH_ARCHIVE_STORAGE_ENGINE=1 \
        -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
        -DMYSQL_TCP_PORT=3306 \
        -DSYSCONFDIR=/etc \
        -DENABLE_DOWNLOADS=1;
        make; make isntall;rm -rf /etc/my.cnf; cp support-files/my-default.cnf /etc/my.cnf; cp support-files/mysql.server /etc/init.d/mysqld chmod +x scripts/mysql_install_db; scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql/ --datadir=/usr/local/mysql/data/; ln -s /usr/local/mysql/bin/* /usr/bin/; ln -s /usr/local/mysql/lib/* /usr/lib/; ln -s /usr/local/mysql/lib/* /usr/lib64/;ln -s /usr/local/mysql/man/man1/*  /usr/share/man/man1; ln -s /usr/local/mysql/man/man8/*  /usr/share/man/man8 ;ln -s /usr/local/mysql/libexec/*  /usr/local/libexec ; chown -R mysql.mysql /usr/local/mysql
}

#Define PHP function
function php_install ()
{
        if [ -d /usr/local/mysql ];then
                wget -c $PHP_SRC/$PHP_FILE; tar -zxvf $PHP_FILE; cd $PHP_NALE; ./configure --prefix=/usr/local/php --with-msyql=/usr/local/msyql
        else
                echo -e "033[32mPlease Install msyqld service !033[0m"
        fi
}

#Choice Menus
PS3="Please choice your menu:"
select menu in "Nginx" "Mysql" "PHP"
do
        case $menu in 
                Nginx ) 
                nginx_install ;;
                Mysql )
                mysql_install ;;
                PHP )
                php_install ;;
                * )
                echo -e "\033[32m usage $0 Nginx|Mysql|PHP|Help\033[0m"
        esac
done
