#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Jan-20
# Desc : This Script install the MySQl8 
# Version : v1.6
##########################################
echo "------------------------------------------------------------"
echo "This Script file install the MySQL8 on your Machine."
echo "------------------------------------------------------------"
set -x 
subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
#dnf install -y wget curl
# --------------------- For Local .repo ------------------------------------
# sudo touch /etc/yum.repos.d/mysql8_local.repo ## For Local repo
# # insert into file
# echo -e "[mysql80-community]
# name=MySQL 8.0 Community Server
# baseurl=https://repo.mysql.com/yum/mysql-8.0-community/el/7/x86_64/
# gpgcheck=1
# gpgkey=https://repo.mysql.com/RPM-GPG-KEY-mysql
# enabled=1" > /etc/yum.repos.d/mysql8_local.repo
# # inserting into file done
# sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql 
# sudo yum install -y mysql-server
# ---------------------Local .repo end ---------------------------------
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
sudo wget https://repo.mysql.com//mysql80-community-release-el9-1.noarch.rpm
sudo dnf localinstall mysql80-community-release-el9-1.noarch.rpm -y
###dnf repolist enabled | grep "mysql.*-community.*"
sudo dnf install mysql-community-server -y
sudo systemctl start mysqld
sudo systemctl enable mysqld
sudo systemctl status mysqld
mysql --version  #mysql -V
sudo grep 'temporary password' /var/log/mysqld.log
# dnf -y install @mysql
# sudo systemctl enable mysqld.service
# sudo systemctl start mysqld.service
# sudo systemctl status mysqld.service
# mysql --version  #mysql -V
# sudo grep 'temporary password' /var/log/mysqld.log
set +x
echo " - - - "
echo "Run mysql secure configuration cmd --> mysql_secure_installation"
#mysql -u root -p
