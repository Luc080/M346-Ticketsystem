#!/bin/bash
set -e
 
echo "MariaDB-Setup wird gestartet..."
 
# Überprüfen, ob MariaDB bereits installiert ist
    echo "MariaDB wird installiert..."
    sudo yum update -y
    sudo yum install -y mariadb-server
 
 
# MariaDB starten und aktivieren
echo "MariaDB wird gestartet und für den Autostart aktiviert..."
sudo systemctl start mariadb
sudo systemctl enable mariadb
 
# Einrichten der Datenbank und des Benutzers
echo "Richte die Datenbank ein..."
sudo mysql <<EOF
-- Erstelle die Datenbank, falls sie nicht existiert
CREATE DATABASE osticket;
 
-- Erstelle den Benutzer neu
CREATE USER 'osticketuser'@'%' IDENTIFIED BY 'Riethuesli>12345';
 
-- Weise Berechtigungen zu
GRANT ALL PRIVILEGES ON osticket.* TO 'osuser'@'%';
 
-- Übernehme die Änderungen
FLUSH PRIVILEGES;
EOF
 
# Anpassen der MariaDB-Konfiguration für Remote-Zugriff
CONFIG_FILE="/etc/my.cnf"
if ! grep -q "^bind-address\s*=\s*0.0.0.0" $CONFIG_FILE; then
    echo "Bind-Adresse wird auf 0.0.0.0 gesetzt..."
    sudo sed -i "s/^bind-address\s*=.*/bind-address = 0.0.0.0/" $CONFIG_FILE
    sudo systemctl restart mariadb
else
    echo "Bind-Adresse ist bereits korrekt konfiguriert."
fi
 
# Logging aktivieren
LOGFILE="/var/log/mariadb_setup.log"
exec > >(tee -i $LOGFILE) 2>&1 
 
# Warte auf den MariaDB-Dienst
for i in {1..10}; do
    if systemctl is-active --quiet mariadb; then
        echo "MariaDB-Dienst läuft."
        break
    fi
    echo "Warte auf MariaDB-Dienst..."
    sleep 1
done
 
echo "MariaDB-Setup abgeschlossen. Datenbank '${DB_NAME}' und Benutzer '${DB_USER}' wurden erfolgreich eingerichtet."
