#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Jan-21
# Desc : This Script install the MySQl5.7 on RHEL
# Version : v1.6
##########################################

set -x
subscription-manager repos --enable codeready-builder-for-rhel-8-$(arch)-rpms
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo dnf remove @mysql -y
sudo dnf -y module reset mysql
sudo dnf -y module disable mysql
sudo touch /etc/yum.repos.d/mysql-community.repo

echo -e "[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/x86_64/
enabled=1
gpgcheck=0" > /etc/yum.repos.d/mysql57-community.repo

sudo dnf config-manager --disable mysql80-community
sudo dnf config-manager --enable mysql57-community
sudo rm -rvf /etc/mysql && sudo rm -rvf /var/lib/mysql
sudo dnf -y install mysql-community-server
systemctl start mysqld && sudo systemctl enable --now mysqld.service && systemctl status mysqld
sudo grep 'A temporary password' /var/log/mysqld.log |tail -1
