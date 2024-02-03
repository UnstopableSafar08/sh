#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Jan-21
# Desc : This Script uninstall the MySQL
# Version : v1.3
##########################################

set -x

sudo yum remove mysql* -y
sudo rm -rvf /etc/mysql && sudo rm -rvf /var/lib/mysql && sudo rm -rvf  /var/log/mysqld.log
rpm -qa | grep mysql 
rpm -qa mysql-*

sudo yum remove -y mysql-community-*

rpm -e --nodeps mysql57-community-release
rpm -e --nodeps mysql80-community-release

yum clean all

