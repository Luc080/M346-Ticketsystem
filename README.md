# M346-Ticketsystem
### Projektarbeit M346

Dieses Repository wurde von **Yeremy Frei**, **Massimo Montesarchio** und **Luc Aeby** im Rahmen der Projektarbeit im Modul 346 erstellt.

Die Dokumentation findest man unter https://github.com/Luc080/M346-Ticketsystem/blob/main/Dokumentation.md

Unser Projekt zielt darauf ab, eine AWS-Infrastruktur für ein Ticketsystem mit **zoho** bereitzustellen. Es beinhaltet:
- Einen **Webserver** mit **PHP** und **Apache**
- Einen **Datenbankserver** mit **MariaDB**

---

## Voraussetzungen
Damit man das Projekt ausführen kannst, solltest man Folgendes installiert und konfiguriert haben:
- **AWS CLI**
- **git**, um das Repository lokal zu klonen

---

## Installation
1. **Repository lokal klonen**:  
   Beginnen wir mit dem klonen des Projektes auf das lokale System und wechsle in den entsprechenden Ordner:
   ```bash
   git clone https://github.com/Luc080/M346-Ticketsystem.git
   cd M346-Ticketsystem
   ```

2. **Skript ausführbar machen und starten**:  
   Setze die richtigen Rechte für deploy_infra.sh und starte die Installation:
   ```bash
   chmod u+x deploy_infra.sh
   ./deploy_infra.sh
   ```

3. **Zugriff auf den Webserver**:  
   Sobald das Skript erfolgreich durchgelaufen ist, kannst man die IP-Adresse des Webservers in den Browser eingeben, um aufs Ticketsystem zuzugreifen.

---