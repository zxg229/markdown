#!/bin/sh
rpm -Uvh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
rpm -Uvh https://www.percona.com/redir/downloads/percona-release/redhat/latest/percona-release-0.1-4.noarch.rpm
yum -y install epel-release
yum -y install gcc gcc-c++ autoconf automake make
yum -y install zlib zlib-devel openssl openssl-devel pcre pcre-devel
yum -y install ack screen wget curl zip unzip ntpdate
yum -y install net-snmp net-snmp-devel net-snmp-utils vim git bind-utils
yum -y install tar nc htop iotop iftop telnet wget curl curl-devel
yum -y remove mysql-server mysql httpd
yum -y install nginx nginx-module-geoip Percona-Server-server-55 percona-xtrabackup-24
yum -y install libwebp-devel libwebp-tools ImageMagick ImageMagick-devel 
yum -y install yum-utils
yum-complete-transaction
yum -y install sudo


# libmcrypt
# rpm -Uvh http://mirrors.hust.edu.cn/epel//5/x86_64/epel-release-5-4.noarch.rpm
# yum -y install libmcrypt libmcrypt-devel mcrypt mhash

yum -y install php71w php71w-fpm php71w-common php71w-cli php71w-devel php71w-intl php71w-mysqlnd php71w-pdo php71w-soap php71w-tidy php71w-xml php71w-xmlrpc php71w-zts php71w-gd php71w-mbstring php71w-mcrypt php71w-pecl-zendopcache php71w-pear php71w-posix php71w-mysqlnd php71w-pecl-redis

# Yar安装
yum -y install curl-devel
pecl install msgpack-2.0.2
pecl install yar-2.0.1

cd /etc/php.d  && echo "extension=msgpack.so" > msgpack.ini && echo "extension=yar.so" > yar.ini
service php-fpm restart


# mysql 5.7
rpm     -Uvh    http://dev.mysql.com/get/mysql57-community-release-el6-8.noarch.rpm
yum -y install mysql-community-server



# 更换时区
echo "ZONE=Asia/Shanghai" > /etc/sysconfig/clock
rm -f  /etc/localtime 
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


#### 安装redis
mkdir -p /opt/data/redis/6379
wget http://download.redis.io/releases/redis-stable.tar.gz
tar xzf redis-stable.tar.gz
cd redis-stable
cd src && make && make install
cd ../ && sh utils/install_server.sh
/bin/cp -f /opt/nfs.localdomain/env/6379.conf /etc/redis/6379.conf
service redis_6379 restart

####安装 composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer


#### 安装java
curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.rpm"
rpm -ivh jdk-8u45-linux-x64.rpm
javac -version





# git 自动补全,设置别名
wget -O ~/.git-completion.bash https://raw.githubusercontent.com/git/git/3bc53220cb2dcf709f7a027a3f526befd021d858/contrib/completion/git-completion.bash 
echo "" > ~/.bashrc && echo "source ~/.git-completion.bash" >> ~/.bashrc
source ~/.git-completion.bash


git config --global alias.st status
git config --global alias.br branch
git config --global alias.cm commit



# salt
1, 安装saltStrack
yum 安装
sudo yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm -y
sudo yum clean expire-cache
sudo yum install salt-master -y    
sudo yum install salt-minion -y    


echo "master: pg01" >> /etc/salt/minion
service salt-minion restart && service salt-master restart
salt-key -L # 查看列表
salt-key -A -y   # 添加minion
salt-key -L
salt '*' cmd.run "cd / && ls"



# 邮件服务安装postfix
yum -y install mailx postfix
service postfix start
echo "123" | mail -s "邮件服务安装完毕" "zhanglei@nutsmobi.com"
