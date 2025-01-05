#!/bin/bash
# Author: Sagar Malla
# Email: sagarmalla08@gmail.com
# Date: 03-JAN, 2025
# Description: This script will generate the RSA-KEY pair by using OpenSSL with the desired key length (size) and different formats of keys.

# Clear the screen
clear

# function that ask key pair name to user.
rsa_key_pair_name() {
    echo -e "\n********************************************************"
    while true; do
        read -p "      # Enter a RSA_KEY_PAIR Name ::: " prefix
        if [[ -z "$prefix" ]]; then
            echo -e "      Name cannot be empty. Please try again.\n"
        elif [[ "$prefix" =~ ^[a-zA-Z_-]+$ ]]; then
            break
        else
            echo -e "\n      Invalid Name. Only letters, underscores (_), and hyphens (-) are allowed.\n"
        fi
    done
}

# Function RSA KEY Length validator.
rsa_keySize() {
    while true; do
        echo -e " -------------------------\n    Choose RSA-Key Size:\n      1. 1024,\n      2. 2048,\n      3. Custom size"
        read -p "      # Enter your Choice  (1, 2, or 3) :: " choice && echo " -------------------------"
        case $choice in
        1)
            keySize=1024
            break
            ;;
        2)
            keySize=2048
            break
            ;;
        3)
            while true; do
                read -p "      # Enter custom RSA key size (>= 512): " customSize
                if [[ "$customSize" =~ ^[0-9]+$ ]] && [ "$customSize" -ge 512 ] && [ $((customSize % 512)) -eq 0 ]; then
                    keySize="$customSize"
                    break
                else
                    echo -e "\n Invalid key size. Please enter a valid key size. Possible size are 512, 1024, 2048, 3072, 4096 etc.\n"
                fi
            done
            break
            ;;
        *)
            echo -e "\n Invalid choice. Please press 1, 2, or 3.\n"
            ;;
        esac
    done
}

# main function start here.
# echo -e "\n********************************************************"
# while true; do
#     read -p "Enter a RSA_KEY_PAIR Name ::: " prefix
#     if [[ -z "$prefix" ]]; then
#         echo -e "RSA_KEY_PAIR Name cannot be empty. Please try again.\n"
#     elif [[ "$prefix" =~ ^[a-zA-Z_-]+$ ]]; then
#         break
#     else
#         echo -e "\n Invalid RSA_KEY_PAIR Name. Only letters, underscores (_), and hyphens (-) are allowed.\n"
#     fi
# done

# Define RSA_KEY_PAIR dir path.
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/${prefix}_rsa_key_pair"
mkdir -p "$script_dir"

# define keys filename.
private_key="$script_dir/${prefix}_private_key.pem"
public_key="$script_dir/${prefix}_public_key.pem"
private_key_pkcs8="$script_dir/${prefix}_private_key_pkcs8.pem"
base64_encoded_key="$script_dir/${prefix}_base64_encoded_private_key.txt"
final_public_key="$script_dir/${prefix}_final_public_key.txt"

# function call rsa_key_pair_name
rsa_key_pair_name

# call rsa-keySize function.
rsa_keySize

# Generates keys-pairs
echo -e "\nINFO +++ Generating KEY Pair ++++ "
openssl genrsa -out "$private_key" $keySize >/dev/null 2>&1 && echo -e "\nPrivate key: $private_key"
openssl rsa -pubout -in "$private_key" -out "$public_key" && echo "Public key: $public_key"
openssl pkcs8 -topk8 -in "$private_key" -inform pem -out "$private_key_pkcs8" -outform pem -nocrypt && echo "PKCS8 key: $private_key_pkcs8"
sed '/-----/d' "$public_key" | tr -d '\n' >"$final_public_key" && echo "Final Public key: $final_public_key"
sed '/-----/d' "$private_key_pkcs8" | tr -d '\n' | base64 -w 0 >"$base64_encoded_key" && echo "Base64 encoded private pkcs8 key: $base64_encoded_key"
echo -e "\nINFO: # KEY GENERATIONS TASK HAS BEEN SUCCESSFUL. #"
echo -e "\n\n****************************\n Newly Generated RSA-KEYs are: " ; tree $script_dir ; echo -e "****************************\n\n"

# END here
