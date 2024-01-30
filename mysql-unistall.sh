#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Jan-21
# Desc : This Script uninstall the MySQL
# Version : v1.1
##########################################

set -x

sudo yum remove mysql* -y
sudo rm -rvf /etc/mysql && sudo rm -rvf /var/lib/mysql
rpm -qa | grep mysql 
rpm -qa mysql-*
yum remove -y mysql-community-libs-5.7.43-1.el7.x86_64
yum remove -y  mysql-community-common-5.7.43-1.el7.x86_64
rpm -e --nodeps mysql57-community-release
rpm -e --nodeps mysql80-community-release

yum clean all

