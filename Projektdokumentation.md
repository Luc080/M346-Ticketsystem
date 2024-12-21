# **Projektdokumentation M346 Ticketsystem**

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

In diesem Teil der Dokumentation gibt es grundlegende Informationen zum Projekt sowie die gegebene Aufgabe, die Wahl des Ticketsystems und die Verteilung der Aufgaben.

### 1.1 Projektaufgabenstellung

Für das Projekt wurde ein Ticketsystem in der Cloud implementiert. Die Konfiguration der Web- und Datenbankserver sowie die Bereitstellung des Systems erfolgten automatisiert über Skripte und YAML-Dateien

### 1.2 Zuständigkeiten

Die Projektaufgaben wurden entsprechend der individuellen Stärken aufgeteilt: Massimo fokussierte sich auf das Layout, Yeremy auf den Code und Luc auf die Dokumentation. Dennoch haben alle Teammitglieder aktiv an allen Bereichen mitgewirkt, codiert, geschrieben und Entscheidungen gemeinsam getroffen.

### 1.3 Entscheidungen
#### 1.3.1 Warum osTicket?

Am Anfgang haben wir uns für Zoho entschieden, da es eine SaaS-Lösung ist. Da wir dies jedoch nicht umsetzen konnten, haben wir uns stattdessen für osTicket entschieden. Diese Lösung liess sich direkt auf unseren Servern installieren und einfach in unsere Infrastruktur integrieren, was die Umsetzung deutlich erleichterte.

#### 1.3.2 Warum Terraform?

Ursprünglich wollten wir YAML für unsere AWS-Infrastruktur verwenden. Wir haben uns jedoch für Terraform entschieden, da es speziell für Infrastructure-as-Code (IaC) entwickelt wurde. Terraform bietet Funktionen wie integriertes State-Management, die Möglichkeit, geplante Änderungen zu simulieren, und eine breite Unterstützung für Cloud-Provider wie AWS. Dadurch eignet es sich besser, Infrastruktur effizient und zuverlässig zu verwalten, während YAML hauptsächlich ein Datenformat ist.

## 2. Skripte

Wir haben drei verschiedene Skript-Dateien erstellt: eine Shell-Datei namens `server_erstellen.sh` sowie zwei .yml-Dateien, `datenbankserver.yml` und `webserver.yml`. In diesen Dateien sind alle notwendigen Konfigurationen und Installationen detailliert dokumentiert.

### 2.1 Code erklärt


## 3. Installationsanleitung

Damit alles reibungslos funktioniert, müssen folgende Schritte zuerst erledigt werden:

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


## 6. Reflexion
### 6.1 Luc Aeby

### 6.2 Massimo Montesarchio



### 6.3 Yeremy Frei




