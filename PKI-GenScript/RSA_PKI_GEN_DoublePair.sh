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

# function validates the rsa-key length/size
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
                    echo -e "    Invalid key size. Please enter a valid key size. Possible key-size are 512, 1024, 2048, 3072, 4096 etc.\n"
                fi
            done
            break
            ;;
        *)
            echo -e "\n    Invalid choice. Please press 1, 2, or 3.\n"
            ;;
        esac
    done
}

# Function, generates the rsa-key pair along with different different formate.
generate_keys() {
    local dir=$1
    local prefix=$2
    private_key="$dir/${prefix}_private_key.pem"
    public_key="$dir/${prefix}_public_key.pem"
    final_public_key="$dir/${prefix}_final_public_key.txt"
    private_key_pkcs8="$dir/${prefix}_private_key_pkcs8.pem"
    base64_key="$dir/${prefix}_base64_encoded_pkcs8_private_key.txt"

    # echo -e "\n ### Selected Key-size is: $keySize and openSSL CMD:: openssl genrsa -out "$private_key" $keySize ### \n\n"
    openssl genrsa -out "$private_key" $keySize >/dev/null 2>&1
    echo "Private key generated: $private_key"
    openssl rsa -pubout -in "$private_key" -out "$public_key" >/dev/null 2>&1
    echo "Public key extracted: $public_key"
    sed '/-----/d' "$public_key" | tr -d '\n' >"$final_public_key"
    echo "Final Public Key: $final_public_key"
    openssl pkcs8 -topk8 -in "$private_key" -inform pem -out "$private_key_pkcs8" -outform pem -nocrypt >/dev/null 2>&1
    echo "Private Key - PKCS8: $private_key_pkcs8"
    sed '/-----/d' "$private_key_pkcs8" | tr -d '\n' | base64 -w 0 >"$base64_key"
    echo "Private Key Base64 encoded PKCS8: $base64_key"
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

# Define RSA_KEY_PAIRS parent and child directories path.
base_dir="./$prefix"
encryption_dir="$base_dir/${prefix}_encryption_key_pair"
signature_dir="$base_dir/${prefix}_signature_key_pair"
mkdir -p "$encryption_dir" "$signature_dir"

# function call rsa_key_pair_name
rsa_key_pair_name

# Function call : rsa-keySize validation
rsa_keySize

# Function Call : key generations.
echo -e "\nINFO +++ Generating Encryption Key Pair +++ " && generate_keys "$encryption_dir" "${prefix}_enc"
echo -e "\nINFO +++ Generating Signature Key Pair +++ " && generate_keys "$signature_dir" "${prefix}_sign"
echo -e "\nINFO: # KEY GENERATIONS TASK HAS BEEN SUCCESSFUL. #"
echo -e "\n--------------------------\nNewly Generated RSA-KEYs are:" ; tree $base_dir ; echo -e "****************************\n\n"

# END here.
