#!/bin/bash
set -e
 
# Update-Pakete und grundlegende Software installieren
echo "Installation des Webservers und der PHP-Umgebung beginnt..." 
sudo yum update -y; sudo amazon-linux-extras enable php8.2; 
sudo yum install -y httpd php php-mysqli wget unzip

# Starten und aktivieren des Apache Dienstes
echo "Starte Apache..." sudo systemctl start httpd; 
sudo systemctl enable httpd

 
# osTicket herunterladen und einrichten
echo "Lade osTicket herunter..."
wget -O /tmp/osTicket.zip https://github.com/osTicket/osTicket/releases/download/v1.18.1/osTicket-v1.18.1.zip
sudo mkdir -p /var/www/html/osticket
sudo unzip -o /tmp/osTicket.zip -d /var/www/html/osticket

# Verschiebe osTicket-Dateien in das Apache-Webroot
echo "Verschiebe osTicket-Dateien ins Webroot..."
if [ -d "/var/www/html/osticket/upload" ]; then
    sudo cp -r /var/www/html/osticket/upload/* /var/www/html/
    
    # Überprüfen, ob die Datei existiert und kopieren
    if [ -f "/var/www/html/osticket/upload/include/ost-sampleconfig.php" ]; then
        sudo cp /var/www/html/osticket/upload/include/ost-sampleconfig.php /var/www/html/include/ost-config.php
    else
        echo "Die Datei ost-sampleconfig.php wurde nicht gefunden."
    fi
    
    # Temporäre Dateien entfernen
    sudo rm -rf /var/www/html/osticket/upload
fi

# Berechtigungen setzen
echo "Setze Berechtigungen für osTicket..."
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Entfernt vorhandene Osticket-Verzeichnisse
sudo rm -rf /var/www/html/osticket
 
# Erstellen des Include Verzeichnis
sudo mkdir -p /var/www/html/include
 
# aktualisieren der Apache Konfiguration
echo "Passe Apache-Konfiguration an..."
sudo sed -i "s|DocumentRoot \"/var/www/html\"|DocumentRoot \"/var/www/html\"|" /etc/httpd/conf/httpd.conf
cat <<EOF | sudo tee /etc/httpd/conf.d/ticketSystem.conf
<Directory "/var/www/html">
    AllowOverride All
    Require all granted
</Directory>
EOF

# Apache wird neugestartet
echo "Starte Apache neu..."
sudo systemctl restart httpd

# (zum Test) Erstellt eine PHP Info Seite
echo "Erstelle PHP-Info-Seite..."
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/ticketSystem-config.php

echo "Der Webserver wurde erfolgreich eingerichtet! Besuchen Sie die URL, um osTicket zu konfigurieren."
echo "Hinweis: Die Datei ost-sampleconfig.php wird während der Webkonfiguration erstellt."

