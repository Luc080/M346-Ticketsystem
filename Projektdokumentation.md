# **Projektdokumentation M346 Ticketsystem**
Das vorliegende Repository ist das Ergebnis einer gemeinsamen Entwicklung von Yeremy Frei, Luc Aeby und Massimo Montesarchio. In dieser Dokumentation wird der gesamte Projektverlauf detailliert beschrieben, angefangen bei der initialen Planung bis hin zur Fertigstellung des Skripts. Darüber hinaus bieten wir eine ausführliche Anleitung zur Installation des Ticketsystems, das mithilfe unseres Skripts implementiert werden kann.
## **Inhaltsverzeichnis**

[1. Projektinfos](#1-projektinfos) \
&nbsp;&nbsp;&nbsp;[1.1 Projektaufgabenstellung](#11-projektaufgabenstellung) \
&nbsp;&nbsp;&nbsp;[1.2 Zuständigkeiten](#12-zuständigkeiten) \
&nbsp;&nbsp;&nbsp;[1.3 Entscheidungen](#13-entscheidungen) \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1.3.1 Warum osTicket?](#131-warum-osticket) \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1.3.2 Warum Terraform](#132-warum-terraform) \
[2. Skripte](#2-ssripte) \
&nbsp;&nbsp;&nbsp;[2.1 Code erklärt](#21-code-erklärt) \
[3. Installationsanleitung](#3-installationsanleitung) \
[4. Testfälle](#4-testfälle) \
&nbsp;&nbsp;&nbsp;[4.1 Testfall 1 - Webserver Zugriff](#41-testfall-1-webserver-zugriff) \
&nbsp;&nbsp;&nbsp;[4.2 Testfall 2 - Datenbankverbindung](#42-testfall-2-datenbankverbindung) \
[5. Verbesserungen](#5-verbesserungen) \
[6. Reflexionen](#6-reflexion) \
&nbsp;&nbsp;&nbsp;[6.1 Luc Aeby](#61-luc-aeby) \
&nbsp;&nbsp;&nbsp;[6.2 Massimo Montesarchio](#62-massimo-montesarchio) \
&nbsp;&nbsp;&nbsp;[6.3 Yeremy Frei](#63-yeremy-frei)

---
## 1. Projektinfos 

### 1.1 Projektaufgabenstellung

Für das Projekt wurde ein Ticketsystem in der Cloud implementiert. Ziel war es, den gesamten Aufbau des Systems umzusetzen – von der Installation der Instanzen bis hin zum funktionierenden Ticketsystem. Die Konfiguration umfasst sowohl den Web- als auch den Datenbankserver. Die Bereitstellung der erforderlichen Server und Instanzen sowie die Einrichtung der Datenbanken und des Ticket-Tools erfolgen automatisch durch die erstellten Skripte.

### 1.2 Zuständigkeiten

Die Projektaufgaben wurden entsprechend der individuellen Stärken aufgeteilt: Massimo fokussierte sich auf das Layout, Yeremy auf den Code und Luc auf die Dokumentation. Dennoch haben alle Teammitglieder aktiv an allen Bereichen mitgewirkt, codiert, geschrieben und Entscheidungen gemeinsam getroffen.

### 1.3 Entscheidungen

Während des Projekts ergaben sich verschiedene Situationen, in denen wir uns als Gruppe zwischen Zahlreichen Umsetzungsvarianten entscheiden mussten.

#### 1.3.1 Warum osTicket?

Zu Beginn des Projekts hatten wir uns ursprünglich für Zoho als unser Tickettool entschieden. Der Grund dafür war, dass wir eine andere Lösung anbieten wollten als die anderen Gruppen in unserer Klasse. Während des Projekts stiessen wir jedoch auf zahlreiche Schwierigkeiten bei der Umsetzung, weshalb wir uns schliesslich dazu entschieden, das Tickettool erneut zu wechseln. Wir informierten uns, welches Tickettool am besten für unsere Umsetzung geeignet wäre. Da wir bereits von unserer ursprünglichen Entscheidung (Zoho) wussten, dass wir keine SaaS-Lösung verwenden wollten, entschieden wir uns schliesslich für osTicket, da es uns ermöglichte, die Umsetztung nach unseren Vorstellungen vorzunehmen.

#### 1.3.2 Warum Terraform?

Auch bei der Art der Umsetzung waren wir zu Beginn unschlüssig, weshalb wir uns zunächst für die Umsetzung durch YAML-Dateien entschieden hatten. Ähnlich wie bei Zoho stiessen wir jedoch bei der Installation des Apache-Dienstes sowie bei der Installation von osTicket auf mehrere Probleme. Nach zahlreichen Stunden und noch immer keiner vernünftigen Lösung entschieden wir uns, erneut umzuschwenken und Terraform zu verwenden, da es speziell für Infrastructure-as-Code (IaC) entwickelt wurde. Terraform bot uns verschiedene Funktionen, wie z.B. integriertes State-Management, wodurch uns die Umsetzung erstaunlicherweise schnell gelang. Trotz anfänglicher Schwierigkeiten und umfangreichem Rechercheaufwand konnten wir unser System schliesslich mit Terraform wie gewünscht umsetzen.

## 2. Skripte

Für die Implementierung haben wir insgesamt vier Skripte bzw. Konfigurationsdateien benötigt:

Installation.sh:
Das Installation.sh Skript automatisiert die Installation von Terraform. Zudem dient es als Grundlage für die Ausführung aller anderen Skripte.

Terraform-Konfiguration.tf:
Die Terraform-Konfiguration.tf-Datei definiert die gesamte AWS-Infrastruktur. Dazu gehören die Schlüsselpaare, Sicherheitsgruppen sowie die zwei benötigten EC2-Instanzen.

Datenbankserver.sh:
Das Datenbankserver.sh Skript ist für die Installation und Konfiguration unserer MariaDB-Datenbank zuständig. Es legt alles Notwendige fest, einschliesslich der Datenbank, Benutzer, Zugriffsrechte und Passwörter.

Webserver.sh:
Das Webserver.sh Skript übernimmt die Installation unseres Tickettools. Es konfiguriert die Apache-Instanz und installiert gleichzeitig das osTicket-Tool.

### 2.1 Code erklärt
- Im folgenden Abschnitt werden die verschiedenen Skripte erläutert. Zusätzlich sind Erklärungen zu den Skripten direkt in jedem Skript als Kommentare enthalten.

## Installation.sh:

- Bei diesem Codeblock wird Terraform erstmalig installiert.
```bash
#!/bin/bash
set -e
 
echo "Terraform-Setup wird gestartet..."
 
# Installation Terraform
    echo "Installiere Terraform Version ${TERRAFORM_VERSION}..."
    sudo apt-get update -y
    sudo apt-get install -y wget unzip
    wget https://releases.hashicorp.com/terraform/1.5.5/terraform_1.5.5_linux_amd64.zip
    unzip terraform_1.5.5_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    rm terraform_1.5.5_linux_amd64.zip
```

- Initialisiert und Konfiguriert Terraform, um die Infrastruktur zu erstellen.
 ```bash
# Initialisiert und konfiguriert Terraform
echo "Terraform wird eingerichtet"
terraform init
echo "Terraformkonfiguration wird angewendet.."
terraform apply -auto-approve
 ```

- Die öffentlichen IP-Adressen des Webservers, wie auch Datenbankserver werden ausgegeben.
```bash
# Webserver- und Datenbankserver-IPs abrufen
WEB_SERVER_IP=$(terraform output -raw web_server_public_ip 2>/dev/null || echo "Nicht verfügbar")
DB_SERVER_PUBLIC_IP=$(terraform output -raw db_server_public_ip 2>/dev/null || echo "Nicht verfügbar")
```

- Logging aktivieren
```bash
LOGFILE="/var/log/terraform_setup.log"
```

- Sicherstellen, dass die Logdatei existiert oder sie mit sudo erstellt wird
```bash
sudo touch $LOGFILE
```

- Alle Ausgaben (stdout und stderr) in die Logdatei und auf die Konsole leiten
```bash
exec > >(sudo tee -i $LOGFILE) 2>&1
```
- Standardvariablen werden festgelegt
```bash
TERRAFORM_VERSION=${1:-1.5.5}
TERRAFORM_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
 ```
 ```bash
# Überprüfen der Terraform-Version
INSTALLED_VERSION=$(terraform version | head -n 1 | awk '{print $2}' | tr -d 'v')
if [[ "$INSTALLED_VERSION" != "$TERRAFORM_VERSION" ]]; then
    echo "Installierte Terraform-Version ($INSTALLED_VERSION) stimmt nicht mit der gewünschten Version ($TERRAFORM_VERSION) überein."
    exit 1
fi
```

## Webserver.sh

- Update-Pakete und grundlegende Software installieren
```bash
#!/bin/bash
set -e
 
echo "Installation des Webservers und der PHP-Umgebung beginnt..." 
sudo yum update -y; sudo amazon-linux-extras enable php8.2; 
sudo yum install -y httpd php php-mysqli wget unzip
```
- Starten und aktivieren des Apache Dienstes
```bash
echo "Starte Apache..." sudo systemctl start httpd; 
sudo systemctl enable httpd
```
- osTicket herunterladen und einrichten
 ```bash
echo "Lade osTicket herunter..."
wget -O /tmp/osTicket.zip https://github.com/osTicket/osTicket/releases/download/v1.18.1/osTicket-v1.18.1.zip
sudo mkdir -p /var/www/html/osticket
sudo unzip -o /tmp/osTicket.zip -d /var/www/html/osticket
```
- Verschiebe osTicket-Dateien in das Apache-Webroot
```bash
echo "Verschiebe osTicket-Dateien ins Webroot..."
if [ -d "/var/www/html/osticket/upload" ]; then
    sudo cp -r /var/www/html/osticket/upload/* /var/www/html/
```
- Überprüfen, ob die Datei existiert und kopieren
```bash
    if [ -f "/var/www/html/osticket/upload/include/ost-sampleconfig.php" ]; then
        sudo cp /var/www/html/osticket/upload/include/ost-sampleconfig.php /var/www/html/include/ost-config.php
    else
        echo "Die Datei ost-sampleconfig.php wurde nicht gefunden."
    fi
    
    # Temporäre Dateien entfernen
    sudo rm -rf /var/www/html/osticket/upload
fi
```
- Berechtigungen setzen
```bash
echo "Setze Berechtigungen für osTicket..."
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
```
- Entfernt vorhandene Osticket-Verzeichnisse
```bash
sudo rm -rf /var/www/html/osticket
```
- Erstellen des Include Verzeichnis
```bash
sudo mkdir -p /var/www/html/include
 ```
- aktualisieren der Apache Konfiguration
```bash
echo "Passe Apache-Konfiguration an..."
sudo sed -i "s|DocumentRoot \"/var/www/html\"|DocumentRoot \"/var/www/html\"|" /etc/httpd/conf/httpd.conf
cat <<EOF | sudo tee /etc/httpd/conf.d/ticketSystem.conf
<Directory "/var/www/html">
    AllowOverride All
    Require all granted
</Directory>
EOF
```
- Apache wird neugestartet
```bash
echo "Starte Apache neu..."
sudo systemctl restart httpd
```
- Dieser Coeblock dient nur zu tests und wird für die umsetztung nicht benötigt
```bash
echo "Erstelle PHP-Info-Seite..."
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/ticketSystem-config.php
```
- textausgabe in der Konsole
```bash
echo "Der Webserver wurde erfolgreich eingerichtet! Besuchen Sie die URL, um osTicket zu konfigurieren."
echo "Hinweis: Die Datei ost-sampleconfig.php wird während der Webkonfiguration erstellt."
```
## Datenbankserver.sh

- Überprüfen, ob MariaDB bereits installiert ist
```bash
#!/bin/bash
set -e
 
echo "MariaDB-Setup wird gestartet..."
 
    echo "MariaDB wird installiert..."
    sudo yum update -y
    sudo yum install -y mariadb-server
 ```
- MariaDB starten und aktivieren
```bash
echo "MariaDB wird gestartet und für den Autostart aktiviert..."
sudo systemctl start mariadb
sudo systemctl enable mariadb
```
- Datenbank einrichten
```bash
echo "Richte die Datenbank ein..."
sudo mysql <<EOF
```

- Erstelle die Datenbank, falls sie nicht existiert
```bash
CREATE DATABASE osticket;
```
- Erstelle den Benutzer neu
```bash
CREATE USER 'osticketuser'@'%' IDENTIFIED BY 'Riethuesli12345';
```
- Weise Berechtigungen zu
```bash
GRANT ALL PRIVILEGES ON osticket.* TO 'osticketuser'@'%';
```
- Übernehme die Änderungen
```bash
FLUSH PRIVILEGES;
EOF
```
- Anpassen der MariaDB-Konfiguration für Remote-Zugriff
```bash
CONFIG_FILE="/etc/my.cnf"
if ! grep -q "^bind-address\s*=\s*0.0.0.0" $CONFIG_FILE; then
    echo "Bind-Adresse wird auf 0.0.0.0 gesetzt..."
    sudo sed -i "s/^bind-address\s*=.*/bind-address = 0.0.0.0/" $CONFIG_FILE
    sudo systemctl restart mariadb
else
    echo "Bind-Adresse ist bereits korrekt konfiguriert."
fi
 ```
- Logging aktivieren
```bash
LOGFILE="/var/log/mariadb_setup.log"
exec > >(tee -i $LOGFILE) 2>&1
 ```
- Standardwerte
```bash
DB_NAME=${1:-osticket}
DB_USER=${2:-osuser}
DB_PASSWORD=${3:-"Riethuesli>12345"}
 ```
- Warte auf den MariaDB-Dienst
```bash
for i in {1..10}; do
    if systemctl is-active --quiet mariadb; then
        echo "MariaDB-Dienst läuft."
        break
    fi
    echo "Warte auf MariaDB-Dienst..."
    sleep 1
done
 ```
- Ausgabe in der Konsole
```bash
echo "MariaDB-Setup abgeschlossen. Datenbank '${DB_NAME}' und Benutzer '${DB_USER}' wurden erfolgreich eingerichtet."
```

## Terraform-Konfiguration.tf

- konfiguration der Region
```hcl
provider "aws" {
  region = "us-east-1"
}
```
- Erstellen des privaten und öffentlichen Schlüssels mit dem TLS Provider
```hcl
provider "tls" {}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
```
- Erstellen des Key-Pairs in AWS mit dem öffentlichen Schlüssel
```hcl
resource "aws_key_pair" "private_key" {
  key_name   = "private-key"
  public_key = tls_private_key.example.public_key_openssh
}
```
- Erstellen des privaten Schlüssels als Datei
```hcl
resource "local_file" "private_key" {
  filename = "${path.module}/private-key.pem"
  content  = tls_private_key.example.private_key_pem
}
```
- Erstellen der Webserver-Sicherheitsgruppe
```hcl
resource "aws_security_group" "web_security_group" {
  name_prefix = "web-security-group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
- Erstellen der Datenbankserver-Sicherheitsgruppe
```hcl
resource "aws_security_group" "db_security_group" {
  name_prefix = "db-security-group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
- EC2-Instanz für den Webserver
```hcl
resource "aws_instance" "webserver" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu Version 20.04 LTS
  instance_type = "t2.micro"
  key_name      = aws_key_pair.private_key.key_name
  security_groups = [aws_security_group.web_security_group.name]
  user_data = file("Webserver.sh")
  tags = {
    Name = "WebServer"
  }
}
```
- EC2-Instanz für den Datenbankserver
```hcl
resource "aws_instance" "database_server" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu Version 20.04 LTS
  instance_type = "t2.micro"
  key_name      = aws_key_pair.private_key.key_name
  security_groups = [aws_security_group.db_security_group.name]
  user_data = file("Datenbankserver.sh")
  tags = {
    Name = "DBServer"
  }
}
```
- Ausgaben der öffentlichen IP-Adressen
```hcl
output "database_server_public_ip" {
  value = aws_instance.database_server.public_ip
}
output "webserver_public_ip" {
  value = aws_instance.webserver.public_ip
}
```
## 3. Installationsanleitung

Damit alles reibungslos funktioniert, müssen folgende Schritte zuerst erledigt werden:

### Voraussetzungen

- [x] AWS CLI musst installiert sein und korrekt konfiguriert sein.

- [x] Es muss eine Funktionierende Linux Maschine vorhanden sein, welche die nötigen berechtigungen besitzt als auch zugriff ins internet hat. 

- [x] git ist auf deinem System installiert.

### Installation:

1. Das Repository sollte zu beginn geklont werden:
  ```bash
   git clone https://github.com/Luc080/M346-Ticketsystem.git
   cd M346-Ticketsystem
   ```
2. Setzten Sie Die benötigten berechtigungen um das Installation.sh Skript ausführen zu können.
```bash
cd Scripts
chmod 755 installation.sh
```
3. Starten Sie die Installation:
```bash
./Installation.sh
```
4. Greifen Sie nachdem das Skript fertig ist auf den erstellten Webserver zu indem sie die angegebene öffentliche IP in ihrem Brower eingeben.
5. KlicKen Sie in der osTicket anscht auf "Continue"
6. Füllen Sie nu die Angezeigten Felder mit den Angegebenen Informationen ein:
   
| Feld         | Wert                        |
|----------------------|-----------------------------|
| **MySQL Hostname**    | <Datenbankserver_Public_IP>      |
| **MySQL Database**    | osticket                   |
| **MySQL Username**    | osticketuser              |
| **MySQL Password**    | Riethuesli12345             |

7. klicken Sie nun auf "Install Now"

8. Mögliche Lösung:
   
![osticket_konf](https://github.com/Luc080/M346-Ticketsystem/blob/main/Bilder/osTicket_konf.png)

## 4. Testfälle

### 4.1 Testfall 1: Webserver Zugriff
- **Datum:** 21.12.2024
- **Tester:** Yeremy Frei
- **Reslutat:**
Nach dem Ausführen des Installation.sh Skripts mussten wir testen, ob der Webserver erreichbar ist. Dabei haben wir die öffentliche IP-Adresse, die als Ausgabe angezeigt wurde, verwendet und versucht, uns darauf zu verbinden. Zunächst erhielten wir jedoch eine Fehlermeldung, dass der Server nicht erreichbar sei. Nach einigen Minuten funktionierte der Zugriff plötzlich. Wir stellten fest, dass wir zunächst hätten warten müssen, bis die Instanz in AWS vollständig initialisiert wurde – was wir anfangs nicht beachtet hatten. Nach der Initialisierung funktionierte der Zugriff jedoch problemlos, und wir wurden auf das Infofenster von osTicket weitergeleitet.

![Webserver_Zugriff](https://github.com/Luc080/M346-Ticketsystem/blob/main/Bilder/Webserver_Zugriff.png)

### 4.2 Testfall 2: Datenbankverbindung
- **Datum:** 22.12.2024
- **Tester:** Yeremy Frei
- **Resultat:**
Nachdem wir Zugriff auf den Webserver hatten, mussten wir testen, ob die Verbindung zwischen dem Webserver und dem Datenbankserver funktioniert. In der Terraform-Konfiguration (.tf-Datei) sind die dafür notwendigen Ports freigegeben, dennoch mussten wir die Verbindung manuell überprüfen. Zum Testen versuchten wir, uns mit den im datenbank.sh-Skript konfigurierten Zugangsdaten im osTicket-Portal anzumelden. Nach Eingabe aller erforderlichen Daten konnten wir auf ‚Install Now‘ klicken und gelangten erfolgreich ins Tickettool. Während des Tests stellten wir ausserdem fest, dass die Webseite bei falscher Eingabe der Daten nicht erreichbar war. Dadurch konnten wir sicherstellen, dass die Datenbankverbindung ordnungsgemäss funktionierte.

![osTicket_Interface](https://github.com/Luc080/M346-Ticketsystem/blob/main/Bilder/osTicket_Interface.png)

## 5. Verbesserungen
Wie bei jedem Projekt gibt es immer Dinge, die man im Nachhinein anders oder besser machen würde. In unserem Fall hätten wir uns zu Beginn intensiver mit den verschiedenen Tickettools und Umsetzungsarten auseinandersetzen sollen. Dadurch hätten wir uns viel Zeit sparen können, die durch Fehlentscheidungen verloren ging. Ausserdem hätten wir uns unserer Meinung nach von Anfang an grundlegend mehr mit AWS beschäftigen müssen. Statt die notwendigen Informationen parallel zur Umsetzung zu suchen, wäre es sinnvoll gewesen, uns bereits im Vorfeld ein solides Grundwissen zu AWS anzueignen. Dadurch hätten sich vermutlich viele Schwierigkeiten vermeiden lassen, und die Umsetzung wäre deutlich einfacher gewesen. Nichtsdestotrotz hat am Ende alles wie erhofft funktioniert.

## 6. Reflexion
### 6.1 Luc Aeby
Der Start in das Projekt war ehrlich gesagt nicht einfach. Mit den wenigen Informationen, die wir zur Verfügung hatten, und ohne wirkliches Vorwissen, fühlte es sich anfangs wie ein Sprung ins nichts an. Gerade zu Beginn hätten wir mehr Unterstützung vom Lehrer gebrauchen können, besonders was technische Details angeht.
Trotzdem verlief die Umsetzung letztlich besser als erwartet. Insbesondere das Arbeiten mit Markdown war gut machbar, da wie dies bereits kannten. Unsere Gruppe funktionierte sehr gut zusammen – durch die klare Aufgabenteilung konnte jeder seinen Teil effektiv bearbeiten, was uns viel Zeit und Stress erspart hat.
Rückblickend bin ich zufrieden mit unserem Ergebnis. Auch wenn es uns anfangs an Orientierung fehlte, haben wir durch gute Zusammenarbeit und Eigeninitiative vieles erreicht. Für künftige Projekte wäre es hilfreich, wenn wir vorab Grundlagen erhalten könnten, um uns schneller auf die eigentliche Umsetzung konzentrieren zu können. Insgesamt hat mich das Projekt aber weitergebracht, und ich bin froh, dass wir es erfolgreich abschliessen konnten.

### 6.2 Massimo Montesarchio
Mir persönlich hat dieses Projekt nicht besonders gut gefallen. Wir mussten es ohne ausreichendes Vorwissen umsetzen. Im Unterricht hatten wir nur ein Video, das AWS oberflächlich erklärt, und eine Aufgabe, die schwer verständlich war. Ich hätte es besser gefunden, wenn wir zuerst gemeinsam mit dem Lehrer eine ähnliche Übung gemacht hätten. Das hätte uns geholfen, die Grundlagen zu verstehen und einen besseren Einstieg zu finden.

Das Einzige, was ich einigermassen konnte, war Markdown, da ich das in einem Workshop der IMS schon einmal verwendet habe. Yeremy musste mir jedoch das Skript und dessen Funktionsweise erklären, da ich hier nicht so viel beitragen konnte, wie ich gerne gewollt hätte. Insgesamt habe ich in diesem Projekt nicht so viel gelernt, wie sicherlich möglich gewesen wäre. Dennoch fand ich es cool, GitHub zu verwenden. Besonders die Commits fand ich spannend, da man genau nachvollziehen kann, was verändert wurde. Ausserdem war es interessant zu sehen, wie weit wir mit dem Projekt am Ende gekommen sind.

### 6.3 Yeremy Frei
Zu Beginn muss ich ehrlich zugeben, dass ich mich nicht wirklich über dieses Projekt gefreut habe. Ich wurde quasi ins kalte Wasser geworfen, und ich denke, das ging nicht nur mir und meiner Gruppe so sondern auch den anderen Gruppe. Wir hatten anfangs keine klare Vorstellung davon, wie wir das Projekt umsetzen sollten. Mit der Zeit wurde jedoch alles verständlicher, und am Ende des Projekts muss ich sagen, dass es mir letztlich doch geholfen hat. Eine derartige Umsetzung mit AWS hatte ich bisher noch nie durchgeführt. Nach Rücksprache in meiner Firma stellte sich zudem heraus, dass ausser den Lehrlingen auch niemand sonst vergleichbare Erfahrungen gesammelt hat.
Obwohl mich das Projekt mindestens 25 Arbeitsstunden und sicherlich auch einige Nerven gekostet hat, bin ich froh, dass ich es umsetzen konnte. Im Nachhinein denke ich jedoch, dass man das Modul anders hätte gestalten sollen. Wie bereits in den Verbesserungsvorschlägen erwähnt, hätte man zunächst ein solides Grundwissen über AWS aufbauen müssen, bevor man ein solches Projekt startet. Nichtsdestotrotz haben wir es am Ende geschafft, und ich bin stolz auf das Ergebnis.
