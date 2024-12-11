#!/bin/bash

# Skript abbrechen, wenn ein Fehler auftritt
set -e

# Variablen
AWS_REGION="us-east-1"
INSTANCE_TYPE="t2.micro"
KEY_NAME="AWS-cli"
WEB_SECURITY_GROUP_NAME="webServer-gruppe"
DB_SECURITY_GROUP_NAME="dbServer-gruppe"
AMI_ID="ami-0fc5d935ebf8bc3bc"
WEBSERVER_USER_DATA="webServer.yml"
DBSERVER_USER_DATA="dbServer.yml"

# Installiere notwendige Pakete
if ! command -v aws &> /dev/null; then
  echo "AWS CLI wird gerade installiert..."
  sudo apt update
  sudo apt install -y awscli
fi

if ! command -v curl &> /dev/null; then
  echo "installation wird ausgeführt"
  sudo apt install -y curl
fi

# Stelle sicher, dass AWS CLI konfiguriert ist
if ! aws configure get region &> /dev/null; then
  echo "AWS CLI wird konfiguriert..."
  aws configure set region $AWS_REGION
  aws configure
fi

# Lade Cloud-Init-Dateien herunter
if [ ! -f "$WEBSERVER_USER_DATA" ]; then
  echo "Webserver-Cloud-Init-Datei wird heruntergeladen"
  curl -o "$WEBSERVER_USER_DATA" "https://example.com/webServer.yml"
fi

if [ ! -f "$DBSERVER_USER_DATA" ]; then
  echo "Lade Datenbankserver-Cloud-Init-Datei herunter..."
  curl -o "$DBSERVER_USER_DATA" "https://example.com/dbServer.yml"
fi

# Erstelle ein Schlüsselpaar
if ! aws ec2 describe-key-pairs --key-name $KEY_NAME > /dev/null 2>&1; then
  echo "Erstelle Schlüsselpaar $KEY_NAME..."
  aws ec2 create-key-pair --key-name $KEY_NAME --key-type rsa \
    --query 'KeyMaterial' --output text > ~/.ssh/$KEY_NAME.pem
  chmod 400 ~/.ssh/$KEY_NAME.pem
else
  echo "Schlüsselpaar $KEY_NAME existiert bereits."
fi