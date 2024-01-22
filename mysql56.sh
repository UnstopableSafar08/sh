#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Jan-22
# Desc : This Script install the MySQl_5.6
# Version : v1.4
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
gpgcheck=0" > /etc/yum.repos.d/mysql56-community.repo

#sudo rpm --import http://repo.mysql.com/RPM-GPG-KEY-mysql
#sudo yum autoremove
sudo yum install -y mysql-community-server

# set +x #this disable the debug mode 
# echo ''
# echo '-----------------------------------------------------------------------------------'
# echo 'This script will delete all mysql OLD-FILES and FOLDERS. Press 'y' to proceed.'
# read -n 1 -r -p "Press 'y' to delete: " response
# echo
# if [ "$response" = "y" ]; then
#     rm -rvf /etc/mysql && rm -rvf /var/lib/mysql

#     echo "Files and folders deleted successfully."
# else
#     echo "Delete Operation aborted."
# fi
# echo '-----------------------------------------------------------------------------------'
# echo ''
# set -x

sudo rm -rvf /etc/mysql && sudo rm -rvf /var/lib/mysql
sudo systemctl start mysqld && sudo systemctl enable mysqld
sudo grep 'temporary password' /var/log/mysqld.log
sudo mysql_secure_installation
#mysql -u root -p
