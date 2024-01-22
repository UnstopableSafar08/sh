#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Jan-22
# Desc : This Script install the MySQl_5.6
# Version : v1.2
##########################################
set -x
sudo touch /etc/yum.repos.d/mysql56-community.repo
echo -e "[mysql56-community]
name=MySQL 5.6 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.6-community/el/7/x86_64/
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
gpgcheck=0" >> /etc/yum.repos.d/mysql56-community.repo

#sudo rpm --import http://repo.mysql.com/RPM-GPG-KEY-mysql
#sudo yum autoremove
sudo yum install -y mysql-community-server
sudo rm -rvf /etc/mysql && sudo rm -rvf /var/lib/mysql
sudo systemctl start mysqld && sudo systemctl enable mysqld
sudo grep 'temporary password' /var/log/mysqld.log
sudo mysql_secure_installation
#mysql -u root -p
