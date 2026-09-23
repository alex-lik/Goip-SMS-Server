# Goip SMS Server

[English](README.md) | [Русский](README.ru.md) | [Українська](README.uk.md) | [Deutsch](README.de.md)

Infrastructure for sending and receiving SMS through [GOIP](http://www.voip-info.org/goip) gateways: an SMS server with a web UI, MariaDB and a Flask service that forwards incoming messages to Telegram.

## Stack

- **Python 3.9 + Flask** — notification service (notificator)
- **Loguru** — logging with rotation
- **PyMySQL** — access to the GOIP SMS Server schema
- **Telegram Bot API** — message delivery
- **MariaDB 10.5 + Adminer** — gateway data storage
- **Docker Compose** — orchestration of all services

## Project structure

```
.
├── docker-compose.yml        # db, sms server, notificator, adminer
├── goip.sql                  # database schema (applied on first start of db)
├── app_notificator/          # Flask app: forwards SMS to Telegram
│   ├── Dockerfile
│   ├── main.py
│   └── requirements.txt
├── Makefile                  # run commands
└── .env.example              # environment configuration template
```

## Running

```bash
cp .env.example .env
cp app_notificator/.env.example app_notificator/.env   # Telegram tokens
make up
```

On the first start MariaDB creates the database and applies the schema from `goip.sql`.

Useful commands:

```bash
make ps        # container status
make logs      # logs of all services
make restart   # restart
make down      # stop
```

Adminer (the `adminer` profile) is available on the port from `.env` (`ADMINER_PORT`).

## Notificator API

| Method | Path | Description |
| --- | --- | --- |
| `GET` | `/` | service health check |
| `POST` | `/` | receive SMS from the gateway and forward it to Telegram |

`POST` body (form or JSON):

| Field | Description |
| --- | --- |
| `name` | card/gateway name (`goip.name`) |
| `number` | sender number |
| `content` | message text |

Example:

```bash
curl -X POST http://localhost:5001/ \
  -d 'name=Trunk1&number=38000&content=Test'
```

Using the `name` field, the service resolves the card's provider in the database and sends the message to the chat defined by `TG_TOKEN_<PROV>` / `TG_CHAT_ID_<PROV>` in `app_notificator/.env`.

## Configuration

All settings are defined in two environment files (only templates are committed to git):

- `.env` — database credentials, ports, SMS server web UI login;
- `app_notificator/.env` — Telegram tokens and, for a local run, database connection settings.
