#!/usr/bin/env bash

set -ex

sudo yum update -y
sudo yum clean all -y
sudo yum install -y git
sudo yum install -y nginx
sudo yum install -y mysql
sudo yum install -y php55
sudo yum install -y php55-bcmath
sudo yum install -y php55-cli
sudo yum install -y php55-common
sudo yum install -y php55-dba
sudo yum install -y php55-devel
sudo yum install -y php55-embedded
sudo yum install -y php55-enchant
sudo yum install -y php55-fpm
sudo yum install -y php55-gd
sudo yum install -y php55-gmp
sudo yum install -y php55-imap
sudo yum install -y php55-intl
sudo yum install -y php55-ldap
sudo yum install -y php55-mbstring
sudo yum install -y php55-mcrypt
sudo yum install -y php55-mssql
sudo yum install -y php55-mysqlnd
sudo yum install -y php55-odbc
sudo yum install -y php55-pdo
sudo yum install -y php55-pecl-apc
sudo yum install -y php55-pecl-igbinary
sudo yum install -y php55-pecl-oauth
sudo yum install -y php55-pecl-propro-devel
sudo yum install -y php55-pecl-raphf-devel
sudo yum install -y php55-pecl-xdebug
sudo yum install -y php55-pgsql
sudo yum install -y php55-process
sudo yum install -y php55-pspell
sudo yum install -y php55-recode
sudo yum install -y php55-snmp
sudo yum install -y php55-soap
sudo yum install -y php55-tidy
sudo yum install -y php55-xml
sudo yum install -y php55-xmlrpc
sudo yum install -y wget git gcc-c++ openssl-devel
sudo yum install -y mysql-server

sudo chown -R nginx:nginx  /var/lib/php/5.5/session/
sudo sed -i -e "s/user = apache/user = nginx/g" /etc/php-fpm-5.5.d/www.conf
sudo sed -i -e "s/group = apache/group = nginx/g" /etc/php-fpm-5.5.d/www.conf
sudo sed -i -e "s/short_open_tag = Off/short_open_tag = On/g" /etc/php.ini

sudo sh -c "curl -L https://gist.githubusercontent.com/miya0001/285cc54981305f5f5e13/raw/fc9e731f76e1a33b9c0cd4559b67abaa25ab041d/gistfile1.txt > /etc/nginx/conf.d/concrete5.conf"

git clone git://github.com/creationix/nvm.git ~/.nvm
source ~/.nvm/nvm.sh
nvm install 0.10

cd /var/www
sudo curl -L https://github.com/concrete5/concrete5-5.7.0/archive/5.7.3.1.tar.gz | tar zxvf -
sudo mv concrete5-5.7.0-5.7.3.1 concrete5
sudo chown -R ec2-user:ec2-user /var/www

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
cd /var/www/concrete5/web/concrete/
/usr/local/bin/composer install

cd /var/www/concrete5/build
npm install -g grunt-cli
npm install
grunt release

sudo chown -R nginx:nginx /var/www
sudo chown -R nginx:nginx /var/lib/php

sudo chkconfig nginx on
sudo chkconfig php-fpm-5.5 on
sudo chkconfig mysqld on

sudo /etc/init.d/php-fpm start
sudo /etc/init.d/nginx start
sudo /etc/init.d/mysqld start

sudo sh -c "curl -L https://raw.githubusercontent.com/Launch-with-1-Click/concrete5-ec2-chef/master/files/setup.sh > /usr/share/setup.sh"
sudo sh -c "echo '@reboot nginx bash /usr/share/setup.sh & rm -f /etc/cron.d/c5' > /etc/cron.d/c5"
