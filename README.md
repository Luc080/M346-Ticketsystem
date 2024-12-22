# M346-Ticketsystem
### Projektarbeit M346

Dieses Repository wurde von **Yeremy Frei**, **Massimo Montesarchio** und **Luc Aeby** im Rahmen der Projektarbeit im Modul 346 erstellt.

Die Dokumentation findet man unter https://github.com/Luc080/M346-Ticketsystem/blob/main/Dokumentation.md

Unser Projekt zielt darauf ab, eine AWS-Infrastruktur für ein Ticketsystem mit **osTicket** bereitzustellen. Es beinhaltet:
- Einen **Webserver** mit **PHP** und **Apache**
- Einen **Datenbankserver** mit **MariaDB**

---

## Voraussetzungen
Damit man das Projekt ausführen kannst, solltest man Folgendes installiert und konfiguriert haben:
- **AWS CLI**
- **git**, um das Repository lokal zu klonen

---

## Installation
1. Das Repository sollte zu beginn geklont werden:
     ```bash
   git clone https://github.com/Luc080/M346-Ticketsystem.git
   cd M346-Ticketsystem
   ```
2. Setzten Sie Die benötigten berechtigungen um das Installation.sh Script ausführen zu können.
```bash
chmod 755 installation.sh
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
| **MySQL Hostname**    | <Datenbankserver_Public_IP>      |
| **MySQL Database**    | osticket                   |
| **MySQL Username**    | osticketuser              |
| **MySQL Password**    | Riethuesli12345             |

7. klicken Sie nun auf "Install Now"

8. Mögliche Lösung:
   
![osticket_konf](https://github.com/Luc080/M346-Ticketsystem/blob/main/Bilder/osTicket_konf.png)
---
