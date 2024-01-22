#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Jan-21
# Desc : This Script install the MySQl5.7 on RHEL
# Version : v1.2
##########################################

set -x
sudo dnf remove @mysql -y
sudo dnf -y module reset mysql
sudo dnf -y module disable mysql
sudo touch /etc/yum.repos.d/mysql-community.repo

echo -e "[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/x86_64/
enabled=1
gpgcheck=0

[mysql-connectors-community]
name=MySQL Connectors Community
baseurl=http://repo.mysql.com/yum/mysql-connectors-community/el/7/x86_64/
enabled=1
gpgcheck=0

[mysql-tools-community]
name=MySQL Tools Community
baseurl=http://repo.mysql.com/yum/mysql-tools-community/el/7/x86_64/
enabled=1
gpgcheck=0" >> /etc/yum.repos.d/mysql-community.repo


sudo dnf config-manager --disable mysql80-community
sudo dnf config-manager --enable mysql57-community
sudo dnf -y install mysql-community-server
sudo rm -rvf /etc/mysql && sudo rm -rvf /var/lib/mysql
systemctl start mysqld && sudo systemctl enable --now mysqld.service && systemctl status mysqld
sudo grep 'A temporary password' /var/log/mysqld.log |tail -1
