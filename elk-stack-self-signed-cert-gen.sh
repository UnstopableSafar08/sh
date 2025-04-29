#!/bin/bash

# ==== CONFIGURATION ====
CA_DIR="/etc/elasticsearch/certs/ca"
CERTS_DIR="/etc/elasticsearch/certs"
SERVICES=("elasticsearch" "logstash" "kibana")
IP_ADDRESS="0.0.0.0"  # Change to specific IP if needed
# ========================

# Ensure cert directories exist
mkdir -p "$CA_DIR" "$CERTS_DIR"

echo "[*] Generating Certificate Authority (CA)..."
if [ ! -f "$CA_DIR/ca.crt" ]; then
  /usr/share/elasticsearch/bin/elasticsearch-certutil ca --pem --out "$CERTS_DIR/ca.zip"
  unzip -o "$CERTS_DIR/ca.zip" -d "$CERTS_DIR"
fi

# Generate certs for each ELK service
for service in "${SERVICES[@]}"; do
  echo "[*] Generating cert for: $service"
  /usr/share/elasticsearch/bin/elasticsearch-certutil cert \
    --out "$CERTS_DIR/${service}.zip" \
    --name "$service" \
    --ca-cert "$CA_DIR/ca.crt" \
    --ca-key "$CA_DIR/ca.key" \
    --ip "$IP_ADDRESS" \
    --pem

  unzip -o "$CERTS_DIR/${service}.zip" -d "$CERTS_DIR/$service"
done

echo "[✓] Certificate generation complete. Certs stored under: $CERTS_DIR/{elasticsearch,logstash,kibana}/"
