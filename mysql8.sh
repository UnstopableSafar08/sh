#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Jan-20
# Desc : This Script install the MySQl8 
# Version : v1.4
##########################################
echo "------------------------------------------------------------"
echo "This Script file install the MySQL8 on your Machine."
echo "------------------------------------------------------------"
set -x 
#set -e

sudo yum -y install epel-release
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023 
sudo wget https://repo.mysql.com//mysql80-community-release-el9-1.noarch.rpm
sudo yum -y localinstall mysql80-community-release-el9-1.noarch.rpm
yum repolist enabled | grep "mysql.*-community.*"
sudo yum -y install mysql-community-server 
sudo systemctl start mysqld
sudo systemctl enable mysqld
sudo systemctl status mysqld
mysql --version  #mysql -V
sudo grep 'temporary password' /var/log/mysqld.log
mysql_secure_installation
#mysql -u root -p
