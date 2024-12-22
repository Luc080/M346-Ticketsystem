#!/bin/bash
set -e
 
echo "Terraform-Setup wird gestartet..."
 
# Überprüfen, ob Terraform bereits installiert ist
    echo "Installiere Terraform Version ${TERRAFORM_VERSION}..."
    sudo apt-get update -y
    sudo apt-get install -y wget unzip
    wget https://releases.hashicorp.com/terraform/1.5.5/terraform_1.5.5_linux_amd64.zip
    unzip terraform_1.5.5_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    rm terraform_1.5.5_linux_amd64.zip
 
# Initialisiern und KonfigurationTerraform
echo "Terraform wird eingerichtet"
terraform init
echo "Terraformkonfiguration wird angewendet.."
terraform apply -auto-approve
 
# Webserver- und Datenbankserver-IPs abrufen
WEB_SERVER_IP=$(terraform output -raw web_server_public_ip 2>/dev/null || echo "Nicht verfügbar")
DB_SERVER_PUBLIC_IP=$(terraform output -raw db_server_public_ip 2>/dev/null || echo "Nicht verfügbar")

# Logging aktivieren
LOGFILE="/var/log/terraform_setup.log"

# Sicherstellen, dass die Logdatei existiert oder sie mit sudo erstellt wird
sudo touch $LOGFILE

# Alle Ausgaben (stdout und stderr) in die Logdatei und auf die Konsole leiten
exec > >(sudo tee -i $LOGFILE) 2>&1

# Standardvariablen
TERRAFORM_VERSION=${1:-1.5.5}
TERRAFORM_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
 
 
# Überprüfen der Terraform-Version
INSTALLED_VERSION=$(terraform version | head -n 1 | awk '{print $2}' | tr -d 'v')
if [[ "$INSTALLED_VERSION" != "$TERRAFORM_VERSION" ]]; then
    echo "Installierte Terraform-Version ($INSTALLED_VERSION) stimmt nicht mit der gewünschten Version ($TERRAFORM_VERSION) überein."
    exit 1
fi
