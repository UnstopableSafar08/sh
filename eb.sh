#!/bin/bash
# Author : Sagar Malla
# Email : sagar.malla@esewa.com.np
# Date : 2023-11-30
echo ""
echo "------------------------ INSTALL REQUIRED PACKAGES ------------------------"
yum install wget -y; yum install -y tar; yum install -y curl; yum install -y telnet
echo "------------------------ REQUIRED PACKAGES INSTALLATION - DONE ------------------------"
echo ""
#------------------------ VARIABLES ------------------------"
USERNAME="eSewa"
PASSWORD="3s3w@"
TOMCAT="10"
TOMCATVER="10.1.13"
HOME="/home/eSewa/"
echo ""
echo "------------------------ USER CREATIONS ------------------------"
useradd -m $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
echo "------------------------ eSewa USER CREATIONS - DONE ------------------------"
echo ""
echo "------------------------ JAVA DOWNLOAD AND CONFIGURATIONS ------------------------"
wget https://download.oracle.com/java/20/archive/jdk-20_linux-x64_bin.tar.gz
chmod +x jdk-20*.tar.gz; tar -xvzf jdk-20*.tar.gz; rm -rf jdk-20*.tar.gz
mv -fvi jdk* .java; mv -fvi .java /home/eSewa/
echo "------------------------ JAVA CONFIGURATION - DONE ------------------------"
echo ""
echo "------------------------ TOMCAT DOWNLOAD AND CONFIG ------------------------"
wget https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT/v$TOMCATVER/bin/apache-tomcat-$TOMCATVER.tar.gz
#wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.13/bin/apache-tomcat-10.1.13.tar.gz
chmod +x apache-tomcat*.tar.gz; tar -xvzf apache-tomcat*.tar.gz; rm -rf apache-tomcat*.tar.gz
mv -fvi apache* eSewa; mv -fvi eSewa/ /home/eSewa/; rm -rf apache*
chown -R eSewa:eSewa /home/eSewa/eSewa
rm -rf /home/eSewa/eSewa/webapps/*
echo "------------------------ TOMCAT CONFIGURATION - DONE ------------------------"
echo ""
echo 'PATH=$PATH:$HOME/bin' >> /home/eSewa/.bash_profile
echo 'export JAVA_HOME=/home/eSewa/.java' >> /home/eSewa/.bash_profile
echo 'export CATALINA_HOME=/home/eSewa/eSewa' >> /home/eSewa/.bash_profile
echo 'export PATH=/home/eSewa/.java/bin:$CATALINA_HOME/bin:$PATH' >> /home/eSewa/.bash_profile
echo 'export PATH' >> /home/eSewa/.bash_profile
echo "------------------------ JAVA AND CATALINA PATH SET - Done ------------------------" 
echo ""
echo "------------------------ APPLY SOURCE, which java and VERSIONS OF JAVA CHECK ------------------------"
source /home/eSewa/.bash_profile
echo ""
which java
echo ""
java -version
echo ""
ls -al /home/eSewa/eSewa/
echo ""
echo "------------------------ REQUIRED PACKAGES, USER, JAVA AND TOMCAT HAS BEEN INSTALLED SUCCESFULLY ------------------------"
echo ""
