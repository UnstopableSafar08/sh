#!/bin/bash

clear
# Prompt user for prefix
echo -e "\n********************************************************"
read -p "Enter a prefix for the rsa-keys ::: " prefix

# Define the script and output directory
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/${prefix}_rsa_key_pair"
mkdir -p "$script_dir"

# Define file paths
private_key="$script_dir/${prefix}_private_key.pem"
public_key="$script_dir/${prefix}_public_key.pem"
private_key_pkcs8="$script_dir/${prefix}_private_key_pkcs8.pem"
base64_encoded_key="$script_dir/${prefix}_base64_encoded_private_key.txt"
final_public_key="$script_dir/${prefix}_final_public_key.txt"

# Generate keys and convert formats
openssl genrsa -out "$private_key" 2048 >/dev/null 2>&1 && echo -e "\nPrivate key: $private_key"
openssl rsa -pubout -in "$private_key" -out "$public_key" && echo "Public key: $public_key"
openssl pkcs8 -topk8 -in "$private_key" -inform pem -out "$private_key_pkcs8" -outform pem -nocrypt && echo "PKCS8 key: $private_key_pkcs8"
sed '/-----/d' "$public_key" | tr -d '\n' > "$final_public_key" && echo "Final Public key: $final_public_key"
sed '/-----/d' "$private_key_pkcs8" | tr -d '\n' | base64 -w 0 > "$base64_encoded_key" && echo "Base64 encoded private pkcs8 key: $base64_encoded_key"

echo -e "\n****************************\n Newly Created RSA-KEYs are: "
tree $script_dir

# END of script.