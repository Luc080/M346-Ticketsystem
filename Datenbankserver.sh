#!/bin/bash
set -e

# Logging aktivieren
LOGFILE="/var/log/mariadb_setup.log"
exec > >(tee -i $LOGFILE) 2>&1

# Standardwerte
DB_NAME=${1:-osticket}
DB_USER=${2:-osTicketbenutzer}
DB_PASSWORD=${3:-"Riethuesli>12345"}

echo "MariaDB-Setup wird gestartet..."

# Überprüfen, ob MariaDB bereits installiert ist
if ! command -v mysql &> /dev/null; then
    echo "MariaDB wird installiert..."
    sudo yum update -y
    sudo yum install -y mariadb-server
else
    echo "MariaDB ist bereits installiert."
fi

# MariaDB starten und aktivieren
echo "MariaDB wird gestartet und für den Autostart aktiviert..."
if ! sudo systemctl is-active --quiet mariadb; then
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
else
    echo "MariaDB läuft bereits."
fi

# Warte auf den MariaDB-Dienst
for i in {1..10}; do
    if systemctl is-active --quiet mariadb; then
        echo "MariaDB-Dienst läuft."
        break
    fi
    echo "Warte auf MariaDB-Dienst..."
    sleep 1
done

# Anpassen der MariaDB-Konfiguration für Remote-Zugriff
CONFIG_FILE="/etc/my.cnf"
if ! grep -q "^bind-address\s*=\s*0.0.0.0" $CONFIG_FILE; then
    echo "Bind-Adresse wird auf 0.0.0.0 gesetzt..."
    sudo sed -i "s/^bind-address\s*=.*/bind-address = 0.0.0.0/" $CONFIG_FILE
    sudo systemctl restart mariadb
else
    echo "Bind-Adresse ist bereits korrekt konfiguriert."
fi

# Einrichten der Datenbank und des Benutzers
echo "Datenbank und Benutzer werden eingerichtet..."
sudo mysql <<EOF
-- Erstellen der Datenbank, falls diese nicht existiert
CREATE DATABASE IF NOT EXISTS ${DB_NAME};

-- Anlegen eines Benutzers mit dem angegebenen Passwort
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';

-- Zuweisen der Berechtigungen
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';

-- Änderungen übernehmen
FLUSH PRIVILEGES;
EOF

echo "MariaDB-Setup abgeschlossen. Datenbank '${DB_NAME}' und Benutzer '${DB_USER}' wurden erfolgreich eingerichtet."
