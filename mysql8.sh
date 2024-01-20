#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Jan-20
# Desc : This Script install the MySQl8 
# Version : v1
##########################################
echo "This Script file install the MySQL8 on your Machine."
set -x 
set -e

sudo yum -y install epel-release
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023 
sudo wget https://repo.mysql.com//mysql80-community-release-el9-1.noarch.rpm
sudo yum -y localinstall mysql80-community-release-el9-1.noarch.rpm
dnf repolist enabled | grep "mysql.*-community.*"
sudo yum -y install mysql-community-server 
sudo systemctl status mysqld
sudo systemctl start mysqld
sudo systemctl enable mysqld
mysql --version  #mysql -V
sudo grep 'temporary password' /var/log/mysqld.log
mysql_secure_installation
#mysql -u root -p
