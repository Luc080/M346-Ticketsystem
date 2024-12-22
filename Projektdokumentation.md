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

Auch bei der Art der Umsetzung waren wir zu Beginn unschlüssig, weshalb wir uns zunächst für die Umsetzung durch YAML-Dateien entschieden hatten. Ähnlich wie bei Zoho stießen wir jedoch bei der Installation des Apache-Dienstes sowie bei der Installation von osTicket auf mehrere Probleme. Nach zahlreichen Stunden und noch immer keiner vernünftigen Lösung entschieden wir uns, erneut umzuschwenken und Terraform zu verwenden, da es speziell für Infrastructure-as-Code (IaC) entwickelt wurde. Terraform bot uns verschiedene Funktionen, wie z.B. integriertes State-Management, wodurch uns die Umsetzung erstaunlicherweise schnell gelang. Trotz anfänglicher Schwierigkeiten und umfangreichem Rechercheaufwand konnten wir unser System schließlich mit Terraform wie gewünscht umsetzen.

## 2. Skripte

Für die implementierung haben wir ingseamt vier Scripte bzw Konfigurationen benötigt

Installation.sh:
Das Installation.sh skript automatisier die Installation von Terraform. Zudem wird es für das ausführen aller anderen scripte benötigt.

Terraform-Konfiguration.tf:
Die Terraform-Konfiguration.tf Konfiguration Definiert die gesamte AWS Infrastruktur. Dazu gehören die Schlüsselpaare, Sicherheitsgruppen wie auch die zwei benötigten EC2 Instanzen.

Datenbankserver.sh:
Das Datenbankserver.sh Skript ist für die Installation wie auch Konfiguration Unserer mariaDB Datenbank zuständig. Darin wird alles nötige wie Datenbank, benutzer, zugriff wie auch die passwörter konfiguriert.

Webserver.sh:
Das Webserver.sh Skript ist für die Installation unseres ticket tools zuständig. Es konfiguriert sowohl die Apache instanz und installiert zugleich das osTicket Tool.

### 2.1 Code erklärt


## 3. Installationsanleitung

Damit alles reibungslos funktioniert, müssen folgende Schritte zuerst erledigt werden:

Voraussetztungen: Es muss eine Funktionierende Linux Maschine vorhanden sein, welche die nötigen berechtigungen besitzt als auch zugriff ins internet hat. Zudem sollte git installiert sein.

### Ablauf:

1. das Repository sollte zu beginn geklont werden:
     ```bash
   git clone https://github.com/Luc080/M346-Ticketsystem.git
   cd M346-Ticketsystem.git/Skripts
   ```
2. Insatllieren sie AWS CLI:
   
Installieren Sie das Kommandozeilentool curl mit folgenden Commands:
```bash
sudo apt update
sudo apt install curl
```
Mit curl wird nun die neuste Version der aws cli heruntergeladen, entpackt und installiert:
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
Durch den Abruf der installierten Version prüfen Sie, ob die Installation erfolgreich war:
```bash
aws --version
```
Sie erstellen bzw. aktualisieren die beiden Dateien credentials und config im Verzeichnis (~/.aws) indem Sie den Befehl ```bash aws configure ```ausführen und folgende Werte setzen:

AWS Access Key ID: x (wird später noch überschrieben)
AWS Secret Access Key x (wird später noch überschrieben)
Default region name: us-east-1
Default output format: json

Danach können sie die Credentials direkt aus ihrem aws kopieren und in die Config datei einfügen und speichern.

3. Setzten sie Die benötigten berechtigungen um das Installation.sh Script ausführen zu können.
```bash
chmod u+x installation.sh
```
4. Starten sie die Installation:
```bash
./Installation.sh
```
5. Greifen sie nachdem das Script fertig ist auf den erstellten Webserver zu indem sie die angegebene éffentliche IP in ihrem Brower eingenen.
6. klichen sie in der osTicket anscht auf "Continue"
7. Füllen sie nu die Angezeigten Felder mit den Angegebenen Informationen ein:
| Feld         | Wert                        |
|----------------------|-----------------------------|
| **MySQL Hostname**    | <DB_SERVER_PUBLIC_IP>      |
| **MySQL Database**    | osticket                   |
| **MySQL Username**    | osuser               |
| **MySQL Password**    | Riethuesli>12345             |

8. klicken Sie nun auf "Install Now"
   
### Voraussetzungen

- [x] AWS CLI musst installiert sein und korrekt konfiguriert sein.

- [x] Ausserdem muss eine Ubuntu-Maschine bereit stehen und die notwendigen Berechtigungen, um Ressourcen in AWS zu erstellen haben.

- [x] git ist auf deinem System installiert.


### Installation

**Repository klonen:** \
Lade das Projekt von GitHub herunter und wechsle in den:

    git clone https://github.com/Luc080/M346-Ticketsystem.git
    cd M346-Ticketsystem

**Skript ausführbar machen:** \
Gib dem Installationsskript die notwendigen Berechtigungen und führe es aus:

    chmod u+x deploy.sh
    ./deploy.sh

**Webserver aufrufen:** \
Sobald das Skript abgeschlossen ist, kannst du im Browser die IP-Adresse des Webservers eingeben, um auf die zoho-Oberfläche zuzugreifen.

## 4. Testfälle

### 4.1 Testfall 1

### 4.2 Testfall 2


## 5. Verbesserungen
Es wäre hilfreich gewesen, sich vorher besser mit AWS auseinanderzusetzen, um ein klareres Bild davon zu bekommen, wie es technisch funktioniert und was die Anforderungen an das Projekt und die Infrastruktur sind. Vielleicht hätten wir auch einfach mal ein bisschen mit AWS herumprobieren können, nicht, um die Projektanforderungen direkt zu erfüllen, sondern um AWS auszutesten


## 6. Reflexion
### 6.1 Luc Aeby

### 6.2 Massimo Montesarchio



### 6.3 Yeremy Frei




