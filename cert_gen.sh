#!/bin/bash

# Default names for output files
key_name="server.key"
cert_name="server.crt"

# Check for custom filenames in command arguments
if [ "$1" ]; then
    key_name=$1
fi

if [ "$2" ]; then
    cert_name=$2
fi

# Certificate details; modify as needed
COUNTRY="US"
STATE="OHIO"
LOCALITY="CLE"
ORGANIZATION="CWRU"
ORG_UNIT="csds"
COMMON_NAME="lampi.cert"
EMAIL="oxl51@case.edu"

# Generate a private key
openssl genrsa -out "$key_name" 2048

# Generate a self-signed certificate
openssl req -new -x509 -key "$key_name" -out "$cert_name" -days 365 \
    -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$ORG_UNIT/CN=$COMMON_NAME/emailAddress=$EMAIL"

echo "Generated private key: $key_name"
echo "Generated self-signed certificate: $cert_name"
