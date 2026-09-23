# Goip SMS Server

[English](README.md) | [Русский](README.ru.md) | [Українська](README.uk.md) | [Deutsch](README.de.md)

Infrastruktur zum Senden und Empfangen von SMS über [GOIP](http://www.voip-info.org/goip)-Gateways: ein SMS-Server mit Web-UI, MariaDB und ein Flask-Dienst, der eingehende Nachrichten an Telegram weiterleitet.

## Stack

- **Python 3.9 + Flask** — Benachrichtigungsdienst (notificator)
- **Loguru** — Logging mit Rotation
- **PyMySQL** — Zugriff auf das Schema des GOIP SMS Server
- **Telegram Bot API** — Zustellung der Nachrichten
- **MariaDB 10.5 + Adminer** — Speicherung der Gateway-Daten
- **Docker Compose** — Orchestrierung aller Dienste

## Projektstruktur

```
.
├── docker-compose.yml        # db, sms-server, notificator, adminer
├── goip.sql                  # Datenbankschema (beim ersten Start von db)
├── app_notificator/          # Flask-Anwendung: SMS-Weiterleitung an Telegram
│   ├── Dockerfile
│   ├── main.py
│   └── requirements.txt
├── Makefile                  # Startbefehle
└── .env.example              # Vorlage der Umgebungsvariablen
```

## Start

```bash
cp .env.example .env
cp app_notificator/.env.example app_notificator/.env   # Telegram-Tokens
make up
```

Beim ersten Start erstellt MariaDB die Datenbank und wendet das Schema aus `goip.sql` an.

Nützliche Befehle:

```bash
make ps        # Status der Container
make logs      # Logs aller Dienste
make restart   # Neustart
make down      # Stoppen
```

Adminer (Profil `adminer`) ist über den Port aus `.env` (`ADMINER_PORT`) erreichbar.

## Notificator-API

| Methode | Pfad | Beschreibung |
| --- | --- | --- |
| `GET` | `/` | Gesundheitsprüfung des Dienstes |
| `POST` | `/` | SMS vom Gateway empfangen und an Telegram weiterleiten |

`POST`-Body (Formular oder JSON):

| Feld | Beschreibung |
| --- | --- |
| `name` | Name der Karte/des Gateways (`goip.name`) |
| `number` | Absendernummer |
| `content` | Text der Nachricht |

Beispiel:

```bash
curl -X POST http://localhost:5001/ \
  -d 'name=Trunk1&number=38000&content=Test'
```

Anhand des Feldes `name` ermittelt der Dienst den Anbieter der Karte in der Datenbank und sendet die Nachricht an den Chat, der durch `TG_TOKEN_<PROV>` / `TG_CHAT_ID_<PROV>` in `app_notificator/.env` festgelegt ist.

## Konfiguration

Alle Einstellungen werden in zwei Umgebungsdateien definiert (nur Vorlagen werden in git committet):

- `.env` — Datenbankzugangsdaten, Ports, Zugangsdaten der Web-UI des SMS-Servers;
- `app_notificator/.env` — Telegram-Tokens und bei lokalem Start die Verbindungseinstellungen zur Datenbank.
