# **Projektdokumentation M346 Ticketsystem**
Das vorliegende Repository ist das Ergebnis einer gemeinsamen Entwicklung von Yeremy Frei, Luc Aeby und Massimo Montesarchio. In dieser Dokumentation wird der gesamte Projektverlauf detailliert beschrieben, angefangen bei der initialen Planung bis hin zur Fertigstellung des Skripts. Darüber hinaus bieten wir eine ausführliche Anleitung zur Installation des Ticketsystems, das mithilfe unseres Skripts implementiert werden kann.
## **Inhaltsverzeichnis**

[1. Projektinfos](#1-projektinfos) \
&nbsp;&nbsp;&nbsp;[1.1 Projektaufgabenstellung](#11-projektaufgabenstellung) \
&nbsp;&nbsp;&nbsp;[1.2 Zuständigkeiten](#12-zuständigkeiten) \
&nbsp;&nbsp;&nbsp;[1.3 Entscheidungen](#13-entscheidungen) \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1.3.1 Warum osTicket?](#131-warum-osticket) \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1.3.2 Warum Terraform](#132-warum-terraform) \
[2. Skripte](#2-skripte) \
&nbsp;&nbsp;&nbsp;[2.1 Code erklärt](#21-code-erklärt) \
[3. Installationsanleitung](#3-installationsanleitung) \
[4. Testfälle](#4-testfälle) \
&nbsp;&nbsp;&nbsp;[4.1 Testfall 1](#41-testfall-1) \
&nbsp;&nbsp;&nbsp;[4.2 Testfall 2](#42-testfall-2) \
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
Das Installation.sh-Skript automatisiert die Installation von Terraform. Zudem dient es als Grundlage für die Ausführung aller anderen Skripte.

Terraform-Konfiguration.tf:
Die Terraform-Konfiguration.tf-Datei definiert die gesamte AWS-Infrastruktur. Dazu gehören die Schlüsselpaare, Sicherheitsgruppen sowie die zwei benötigten EC2-Instanzen.

Datenbankserver.sh:
Das Datenbankserver.sh-Skript ist für die Installation und Konfiguration unserer MariaDB-Datenbank zuständig. Es legt alles Notwendige fest, einschliesslich der Datenbank, Benutzer, Zugriffsrechte und Passwörter.

Webserver.sh:
Das Webserver.sh-Skript übernimmt die Installation unseres Tickettools. Es konfiguriert die Apache-Instanz und installiert gleichzeitig das osTicket-Tool.

### 2.1 Code erklärt
- Im folgenden Abschnitt werden die verschiedenen Skripte erläutert. Zusätzlich sind Erklärungen zu den Skripten direkt in jedem Skript als Kommentare enthalten.
- **Installation.sh:**
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
**Erklärung:** Bei diesem Codeblock wird Terraform erstmalig installiert.

 ```bash
# Initialisiert und konfiguriert Terraform
echo "Terraform wird eingerichtet"
terraform init
echo "Terraformkonfiguration wird angewendet.."
terraform apply -auto-approve
 ```
**Erklärung:** Initialisiert und Konfiguriert Terraform, um die Infrastruktur zu erstellen.

```bash
# Webserver- und Datenbankserver-IPs abrufen
WEB_SERVER_IP=$(terraform output -raw web_server_public_ip 2>/dev/null || echo "Nicht verfügbar")
DB_SERVER_PUBLIC_IP=$(terraform output -raw db_server_public_ip 2>/dev/null || echo "Nicht verfügbar")
```
**Erklärung:** Die öffentlichen IP-Adressen des Webservers, wie auch Datenbankserver werden ausgegeben.

# Logging aktivieren
```bash
LOGFILE="/var/log/terraform_setup.log"
```

# Sicherstellen, dass die Logdatei existiert oder sie mit sudo erstellt wird
```bash
sudo touch $LOGFILE
```

# Alle Ausgaben (stdout und stderr) in die Logdatei und auf die Konsole leiten
```bash
exec > >(sudo tee -i $LOGFILE) 2>&1
```
# Standardvariablen werden festgelegt
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
   cd M346-Ticketsystem.git/Skripts
   ```
2. Setzten Sie Die benötigten berechtigungen um das Installation.sh Script ausführen zu können.
```bash
chmod u+x installation.sh
```
3. Starten Sie die Installation:
```bash
./Installation.sh
```
4. Greifen Sie nachdem das Script fertig ist auf den erstellten Webserver zu indem sie die angegebene öffentliche IP in ihrem Brower eingeben.
5. KlicKen Sie in der osTicket anscht auf "Continue"
6. Füllen Sie nu die Angezeigten Felder mit den Angegebenen Informationen ein:
   
| Feld         | Wert                        |
|----------------------|-----------------------------|
| **MySQL Hostname**    | <DB_SERVER_PUBLIC_IP>      |
| **MySQL Database**    | osticket                   |
| **MySQL Username**    | osuser               |
| **MySQL Password**    | Riethuesli>12345             |

7. klicken Sie nun auf "Install Now"

8. Mögliche Lösung:

## 4. Testfälle

### 4.1 Testfall 1: Webserver Zugriff
- **Datum:** 21.12.2024
- **Tester:** Yeremy Frei
- **Reslutat:**
Nach dem Ausführen des installation.sh-Scripts mussten wir testen, ob der Webserver erreichbar ist. Dabei haben wir die öffentliche IP-Adresse, die als Ausgabe angezeigt wurde, verwendet und versucht, uns darauf zu verbinden. Zunächst erhielten wir jedoch eine Fehlermeldung, dass der Server nicht erreichbar sei. Nach einigen Minuten funktionierte der Zugriff plötzlich. Wir stellten fest, dass wir zunächst hätten warten müssen, bis die Instanz in AWS vollständig initialisiert wurde – was wir anfangs nicht beachtet hatten. Nach der Initialisierung funktionierte der Zugriff jedoch problemlos, und wir wurden auf das Infofenster von osTicket weitergeleitet.

### 4.2 Testfall 2: Datenbankverbindung
- **Datum:**22.12.2024
- **Tester:** Yeremy Frei
- **Resultat:**
Nachdem wir Zugriff auf den Webserver hatten, mussten wir testen, ob die Verbindung zwischen dem Webserver und dem Datenbankserver funktioniert. In der Terraform-Konfiguration (.tf-Datei) sind die dafür notwendigen Ports freigegeben, dennoch mussten wir die Verbindung manuell überprüfen. Zum Testen versuchten wir, uns mit den im datenbank.sh-Skript konfigurierten Zugangsdaten im osTicket-Portal anzumelden. Nach Eingabe aller erforderlichen Daten konnten wir auf ‚Install Now‘ klicken und gelangten erfolgreich ins Tickettool. Während des Tests stellten wir ausserdem fest, dass die Webseite bei falscher Eingabe der Daten nicht erreichbar war. Dadurch konnten wir sicherstellen, dass die Datenbankverbindung ordnungsgemäss funktionierte.


## 5. Verbesserungen
Wie bei jedem Projekt gibt es immer Dinge, die man im Nachhinein anders oder besser machen würde. In unserem Fall hätten wir uns zu Beginn intensiver mit den verschiedenen Tickettools und Umsetzungsarten auseinandersetzen sollen. Dadurch hätten wir uns viel Zeit sparen können, die durch Fehlentscheidungen verloren ging. Ausserdem hätten wir uns unserer Meinung nach von Anfang an grundlegend mehr mit AWS beschäftigen müssen. Statt die notwendigen Informationen parallel zur Umsetzung zu suchen, wäre es sinnvoll gewesen, uns bereits im Vorfeld ein solides Grundwissen zu AWS anzueignen. Dadurch hätten sich vermutlich viele Schwierigkeiten vermeiden lassen, und die Umsetzung wäre deutlich einfacher gewesen. Nichtsdestotrotz hat am Ende alles wie erhofft funktioniert.

## 6. Reflexion
### 6.1 Luc Aeby

### 6.2 Massimo Montesarchio



### 6.3 Yeremy Frei
Zu Beginn muss ich ehrlich zugeben, dass ich mich nicht wirklich über dieses Projekt gefreut habe. Ich wurde quasi ins kalte Wasser geworfen, und ich denke, das ging nicht nur mir und meiner Gruppe so sondern auch den anderen Gruppe. Wir hatten anfangs keine klare Vorstellung davon, wie wir das Projekt umsetzen sollten. Mit der Zeit wurde jedoch alles verständlicher, und am Ende des Projekts muss ich sagen, dass es mir letztlich doch geholfen hat. Eine derartige Umsetzung mit AWS hatte ich bisher noch nie durchgeführt. Nach Rücksprache in meiner Firma stellte sich zudem heraus, dass ausser den Lehrlingen auch niemand sonst vergleichbare Erfahrungen gesammelt hat.
Obwohl mich das Projekt mindestens 25 Arbeitsstunden und sicherlich auch einige Nerven gekostet hat, bin ich froh, dass ich es umsetzen konnte. Im Nachhinein denke ich jedoch, dass man das Modul anders hätte gestalten sollen. Wie bereits in den Verbesserungsvorschlägen erwähnt, hätte man zunächst ein solides Grundwissen über AWS aufbauen müssen, bevor man ein solches Projekt startet. Nichtsdestotrotz haben wir es am Ende geschafft, und ich bin stolz auf das Ergebnis.



