#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Jan-22
# Desc : This Script install the MySQl_5.7
# Version : v1.7
##########################################
set -x
sudo yum install epel-release -y
sudo touch /etc/yum.repos.d/mysql57-community.repo
echo -e "[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/x86_64/
enabled=1
gpgcheck=0" > /etc/yum.repos.d/mysql57-community.repo

#sudo rpm --import http://repo.mysql.com/RPM-GPG-KEY-mysql
#sudo yum autoremove
sudo rm -rvf /etc/mysql && sudo rm -rvf /var/lib/mysql
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
sudo systemctl start mysqld && sudo systemctl enable mysqld
sudo grep 'temporary password' /var/log/mysqld.log
#sudo mysql_secure_installation
#mysql -u root -p

