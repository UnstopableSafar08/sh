#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Jan-20
# Desc : This Script install the MySQl8 
# Version : v1.2
##########################################
echo "------------------------------------------------------------"
echo "This Script file install the MySQL8 on your Machine."
echo "------------------------------------------------------------"
set -x 
set -e
#set -o pipefail
sudo yum clean all
#sudo subscription-manager repos --enable codeready-builder-for-rhel-8-$(arch)-rpms
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y 
sudo yum -y install epel-release
dnf -y install @mysql
sudo systemctl enable mysqld.service
sudo systemctl start mysqld.service
sudo systemctl status mysqld.service
sudo mysql_secure_installation
mysql --version  #mysql -V
sudo grep 'temporary password' /var/log/mysqld.log
mysql_secure_installation
#mysql -u root -p
