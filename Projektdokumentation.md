# **Projektdokumentation M346 Ticketsystem**

[1. Projektinfos](#1-projektinfos) \
&nbsp;&nbsp;&nbsp;[1.1 Projektaufgabenstellung](#11-projektaufgabenstellung) \
&nbsp;&nbsp;&nbsp;[1.2 Zuständigkeiten](#12-zuständigkeiten) \
&nbsp;&nbsp;&nbsp;[1.3 Entscheidungen](#13-entscheidungen) \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1.3.1 Warum Zoho?](#131-warum-zoho) \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1.3.2 Warum yaml? (.yml)](#132-warum-yaml-yml) \
[2. Skripte](#2-skripte) \
&nbsp;&nbsp;&nbsp;[2.1 Code erklärt](#21-code-erklärt) \
[3. Installationsanleitung](#3-installationsanleitung) \
[4. Testfälle](#4-testfälle) \
[5. Verbesserungen](#5-verbesserungen) \
[6. Reflexionen](#6-reflexion) \
&nbsp;&nbsp;&nbsp;[6.1 Luc Aeby](#61-luc-aeby) \
&nbsp;&nbsp;&nbsp;[6.2 Massimo](#62-massimo-montesarchio) \
&nbsp;&nbsp;&nbsp;[6.3 Yeremy Frei](#63-yeremy-frei)


## 1. Projektinfos 
In diesem Teil der Dokumentation gibt es grundlegende Informationen zum Projekt sowie die gegebene Aufgabe, die Wahl des Ticketsystems und die Verteilung der Aufgaben.

### 1.1 Projektaufgabenstellung
Für das Projekt wurde ein Ticketsystem in der Cloud implementiert. Die Konfiguration der Web- und Datenbankserver sowie die Bereitstellung des Systems erfolgten automatisiert über Skripte und YAML-Dateien

### 1.2 Zuständigkeiten
Die Projektaufgaben wurden entsprechend der individuellen Stärken aufgeteilt: Massimo fokussierte sich auf das Layout, Yeremy auf den Code und Luc auf die Dokumentation. Dennoch haben alle Teammitglieder aktiv an allen Bereichen mitgewirkt, codiert, geschrieben und Entscheidungen gemeinsam getroffen.

### 1.3 Entscheidungen
#### 1.3.1 Warum osTicket?
Zu Beginn haben wir uns für zoho entschieden, da dies jedoch eine SaaS Lösung ist und wir dies nicht umsetzten konnten, haben wir uns trotzdem noch für osTicket entschieden, weil dies eine direkte Installation ist und dies einfach zu implementieren ist.

#### 1.3.2 Warum Terraform?
Auch hier hatten wir uns zuerts für die Variante mit .yml Dateien entschieden, da wir jedoch Terraform im Nachhinein für sinnvoller hielten, haben wir uns doch für Terraform entschieden. Wir haben uns zuerst mit dem Thema befasst und danach in die Praxis umgesetzt.

## 2. Skripte
Wir haben drei verschiedene Skript-Dateien erstellt: eine Shell-Datei namens `server_erstellen.sh` sowie zwei .yml-Dateien, `datenbankserver.yml` und `webserver.yml`. In diesen Dateien sind alle notwendigen Konfigurationen und Installationen detailliert dokumentiert.

### 2.1 Code erklärt


## 3. Installationsanleitung
Damit alles reibungslos funktioniert, müssen folgende Schritte zuerst erledigt werden:

### Voraussetzungen
- AWS CLI musst installiert sein und korrekt konfiguriert sein.

- Ausserdem muss eine Ubuntu-Maschine bereit stehen und die notwendigen Berechtigungen, um Ressourcen in AWS zu erstellen haben.

- git ist auf deinem System installiert.


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


## 5. Verbesserungen


## 6. Reflexion
### 6.1 Luc Aeby

### 6.2 Massimo Montesarchio

### 6.3 Yeremy Frei




