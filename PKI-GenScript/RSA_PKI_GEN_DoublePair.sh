#!/bin/bash

clear
# Ask for user input to prepend to the key directory names
echo -e "\n********************************************************"
# echo "Enter a Bank Name to Generate PKI Keys"
# echo "+++ e.g. NIC_PKI_Keys +++"
read -p "Enter a Bank Name to Generate RSA-Keys ::: " prefix

# Define key directories
base_dir="./$prefix"
encryption_dir="$base_dir/${prefix}_encryption-key-pair"
signature_dir="$base_dir/${prefix}_signature-key-pair"

# Create directories
mkdir -p "$encryption_dir" "$signature_dir"

# Function to generate keys
generate_keys() {
    local dir=$1
    local prefix=$2

    private_key="$dir/${prefix}_private_key.pem"
    public_key="$dir/${prefix}_public_key.pem"
    final_public_key="$dir/${prefix}_final_public_key.txt"
    private_key_pkcs8="$dir/${prefix}_private_key_pkcs8.pem"
    base64_key="$dir/${prefix}_pkcs8_base64_encoded_private_key.txt"

    # Generate Private Key
    echo -e "\n"
    openssl genrsa -out "$private_key" 2048 > /dev/null 2>&1
    echo "Private key generated: $private_key"

    # Extract Public Key
    openssl rsa -pubout -in "$private_key" -out "$public_key"
    sed '/-----/d' "$public_key" | tr -d '\n' > "$final_public_key"
    echo "Public key extracted and Final Key: $final_public_key"

    # Convert Private Key to PKCS8 Format
    openssl pkcs8 -topk8 -in "$private_key" -inform pem -out "$private_key_pkcs8" -outform pem -nocrypt
    echo "Private Key converted to PKCS8 format: $private_key_pkcs8"

    # Base64 encode the PKCS8 private key
    sed '/-----/d' "$private_key_pkcs8" | tr -d '\n' | base64 -w 0 > "$base64_key"
    echo "Base64 encoded private key saved: $base64_key"
}

# Generate keys for both encryption and signature
generate_keys "$encryption_dir" "${prefix}_encryption"
generate_keys "$signature_dir" "${prefix}_signature"

# Display the directory structure
echo -e "\n--------------------------\nNewly Created RSA-KEYs are:"
tree "$base_dir"

# End of script