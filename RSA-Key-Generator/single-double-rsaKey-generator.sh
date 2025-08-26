#!/bin/bash
# Author: Sagar Malla
# Email: sagarmalla08@gmail.com
# Date: 04-FEB, 2025
# Description: This script will generate the RSA-KEY pair by using OpenSSL with the desired key length (size) and different formats of keys.

# clear the screen.
clear

# function that ask key pair name to user.
rsa_key_pair_name() {
    echo -e "\n********************************************************"
    while true; do
        read -p "    # Enter a RSA_KEY_PAIR Name ::: " prefix
        if [[ -z "$prefix" ]]; then
            echo -e "    Name cannot be empty. Please try again.\n"
        elif [[ "$prefix" =~ ^[a-zA-Z_-]+$ ]]; then
            break
        else
            echo -e "\n      Invalid Name. Only letters, underscores (_), and hyphens (-) are allowed.\n"
        fi
    done
}

# function validate the rsa-key length.
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
                    echo -e "\n    Invalid key size. Please enter a valid key size. Possible key-size are 512, 1024, 2048, 3072, 4096 etc.\n"
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

# function to generate RSA keys
generate_keys() {
    local dir=$1
    local prefix=$2
    private_key="$dir/${prefix}_private_key.pem"
    public_key="$dir/${prefix}_public_key.pem"
    final_public_key="$dir/${prefix}_final_public_key.txt"
    private_key_pkcs8="$dir/${prefix}_private_key_pkcs8.pem"
    base64_key="$dir/${prefix}_base64_encoded_pkcs8_private_key.txt"
    final_KeyPair="$dir/${prefix}_final_keyPair.txt"

    openssl genrsa -out "$private_key" $keySize >/dev/null 2>&1
    # echo "Private key generated: $private_key"
    openssl rsa -pubout -in "$private_key" -out "$public_key" >/dev/null 2>&1
    # echo "Public key extracted: $public_key"
    sed '/-----/d' "$public_key" | tr -d '\n' > "$final_public_key"
    # echo "Final Public Key: $final_public_key"
    openssl pkcs8 -topk8 -in "$private_key" -inform pem -out "$private_key_pkcs8" -outform pem -nocrypt >/dev/null 2>&1
    # echo "Private Key - PKCS8: $private_key_pkcs8"
    sed '/-----/d' "$private_key_pkcs8" | tr -d '\n' | base64 -w 0 > "$base64_key"
    # echo "Private Key Base64 encoded PKCS8: $base64_key"
    echo -e "SUCCESS - Final ready to use Key Pair: $final_KeyPair"
    
    {
        echo "########## FINAL ${prefix} - PRIVATE BASE64 ENCODED KEY ##########"
        cat "$base64_key"
        echo -e "\n\n########## FINAL ${prefix} - PUBLIC KEY ##########"
        cat "$final_public_key"
    } > "$final_KeyPair"

    echo -e "\n********************************************************"
    cat "$final_KeyPair"
    echo -e "\n********************************************************\n"
}

# function to generate the single pair of rsa-key
single_pair_rsa_keys() {
    rsa_key_pair_name
    script_dir="./${prefix}_keyPair"
    mkdir -p "$script_dir"
    rsa_keySize
    generate_keys "$script_dir" "$prefix"
    echo -e "INFO: # KEY GENERATIONS TASK HAS BEEN SUCCESSFUL. #"
    # echo -e "\n\n****************************\n Newly Generated RSA-KEYs are: "
    # tree "$script_dir"
}

# function to generate the double pair (encryption and signature) of rsa-key.
double_pair_rsa_keys() {
    rsa_key_pair_name
    base_dir="./$prefix"
    encryption_dir="$base_dir/${prefix}_encryption_key_pair"
    signature_dir="$base_dir/${prefix}_signature_key_pair"
    mkdir -p "$encryption_dir" "$signature_dir"
    rsa_keySize
    echo -e "\nINFO +++ Generating Encryption Key Pair +++ "
    generate_keys "$encryption_dir" "${prefix}_enc"
    echo -e "\nINFO +++ Generating Signature Key Pair +++ "
    generate_keys "$signature_dir" "${prefix}_sign"
    echo -e "# INFO: KEY GENERATIONS TASK HAS BEEN SUCCESSFUL. #"
    # echo -e "\n--------------------------\nNewly Generated RSA-KEYs are:" 
    # tree "$base_dir"
    # echo -e "****************************\n"
}

# Main Menu Loop
while true; do
    echo -e "-------------------------------------------\n#### openSSL RSA-KEY-Pairs Generator ####\n-------------------------------------------"
    echo -e " Choose an option for RSA-KEY-Pairs Generation:\n ----------------------\n    1. Single Pair.\n    2. Double Pair (sign and enc).\n    3. Exit"
    read -p "    # Enter your choice (1, 2, or 3): " choice

    case $choice in
    1)
        single_pair_rsa_keys
        break
        ;;
    2)
        double_pair_rsa_keys
        break
        ;;
    3)
        echo "Exiting program..."
        break
        ;;
    *)
        echo -e "\n Invalid choice. Please enter 1, 2, or 3."
        ;;
    esac
done
