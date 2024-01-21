#! /bin/bash
##############################################################################################################################
# Author : Sagar Malla
# Date : 2024-Jan-21
# Desc : This Script install and Configure the all requiremewnts for the esewa-bank applications.
# Version : v1.1
##############################################################################################################################
set -x 
yum install -y wget tar curl telnet net-tools
#------------------------ VARIABLES ------------------------"
USERNAME="eSewa"
PASSWORD="3s3w@"
TOMCAT="10"
TOMCATVER="10.1.13"
HOME="/home/eSewa/"
useradd -m $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
wget https://download.oracle.com/java/20/archive/jdk-20_linux-x64_bin.tar.gz
chmod +x jdk-20*.tar.gz; tar -xvzf jdk-20*.tar.gz; rm -rf jdk-20*.tar.gz
mv -fvi jdk* .java; mv -fvi .java /home/eSewa/
wget https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT/v$TOMCATVER/bin/apache-tomcat-$TOMCATVER.tar.gz
#wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.13/bin/apache-tomcat-10.1.13.tar.gz
chmod +x apache-tomcat*.tar.gz; tar -xvzf apache-tomcat*.tar.gz; rm -rf apache-tomcat*.tar.gz
mv -fvi apache* eSewa; mv -fvi eSewa/ /home/eSewa/; rm -rf apache*
chown -R eSewa:eSewa /home/eSewa/eSewa
rm -rf /home/eSewa/eSewa/webapps/*
echo 'PATH=$PATH:$HOME/bin' >> /home/eSewa/.bash_profile
echo 'export JAVA_HOME=/home/eSewa/.java' >> /home/eSewa/.bash_profile
echo 'export CATALINA_HOME=/home/eSewa/eSewa' >> /home/eSewa/.bash_profile
echo 'export PATH=/home/eSewa/.java/bin:$CATALINA_HOME/bin:$PATH' >> /home/eSewa/.bash_profile
echo 'export PATH' >> /home/eSewa/.bash_profile
source /home/eSewa/.bash_profile
which java
java -version
ls -al /home/eSewa/eSewa/


