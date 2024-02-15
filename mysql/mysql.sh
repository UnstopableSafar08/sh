#! /bin/bash
##########################################
# Author : Sagar Malla
# Date : 2024-Feb-15
# Desc : 
# Version : v1.5
##########################################
echo "---------------------"
echo  -e "Choice1 : CentOS-MySQL5.7 \nChoice2 : CentOS-MySQL8 \nChoice3 : RHEL-MySQL5.7 \nChoice4 : RHEL-MySQL8 \nChoice5 : MySQL-Uninstall"
echo "---------------------"
echo "Enter a Choice Number (1-5):"
read choice

case $choice in
    1)
        echo "You selected Option 1."
        # Add your code for Option 1 here
        ;;
    2)
        echo "You selected Option 2."
        # Add your code for Option 2 here
        ;;
    3)
        echo "You selected Option 3."
        # Add your code for Option 3 here
        ;;
    4)
        echo "You selected Option 4."
        # Add your code for Option 4 here
        ;;
    5)
        echo "You selected Option 5."
        # Add your code for Option 5 here
        ;;
    *)
        echo "Invalid choice. Please enter a number between 1 and 5."
        ;;
esac
