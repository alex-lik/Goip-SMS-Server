# Goip SMS Server

[English](README.md) | [Русский](README.ru.md) | [Українська](README.uk.md) | [Deutsch](README.de.md)

Инфраструктура для приёма и рассылки SMS через шлюзы [GOIP](http://www.voip-info.org/goip): SMS-сервер с web-UI, MariaDB и Flask-сервис, который пересылает входящие сообщения в Telegram.

## Стек

- **Python 3.9 + Flask** — сервис уведомлений (notificator)
- **Loguru** — логирование с ротацией
- **PyMySQL** — доступ к схеме GOIP SMS Server
- **Telegram Bot API** — доставка уведомлений
- **MariaDB 10.5 + Adminer** — хранение данных шлюзов
- **Docker Compose** — оркестрация всех сервисов

## Структура проекта

```
.
├── docker-compose.yml        # db, sms-сервер, notificator, adminer
├── goip.sql                  # схема БД (применяется при первом старте db)
├── app_notificator/          # Flask-приложение: пересылка SMS в Telegram
│   ├── Dockerfile
│   ├── main.py
│   └── requirements.txt
├── Makefile                  # команды запуска
└── .env.example              # пример настроек окружения
```

## Запуск

```bash
cp .env.example .env
cp app_notificator/.env.example app_notificator/.env   # токены Telegram
make up
```

При первом запуске MariaDB создаёт базу и применяет схему из `goip.sql`.

Полезные команды:

```bash
make ps        # состояние контейнеров
make logs      # логи всех сервисов
make restart   # перезапуск
make down      # остановка
```

Adminer (профиль `adminer`) доступен на порту из `.env` (`ADMINER_PORT`).

## API notificator

| Метод | Путь | Описание |
| --- | --- | --- |
| `GET` | `/` | проверка доступности сервиса |
| `POST` | `/` | получение SMS от шлюза, пересылка в Telegram |

Тело `POST`-запроса (форма или JSON):

| Поле | Описание |
| --- | --- |
| `name` | имя карты/шлюза (`goip.name`) |
| `number` | номер отправителя |
| `content` | текст сообщения |

Пример:

```bash
curl -X POST http://localhost:5001/ \
  -d 'name=Trunk1&number=38000&content=Test'
```

По полю `name` сервис определяет провайдера карточки в БД и отправляет сообщение в чат, заданный переменными `TG_TOKEN_<PROV>` / `TG_CHAT_ID_<PROV>` из `app_notificator/.env`.

## Конфигурация

Все настройки задаются в двух файлах окружения (в git попадают только примеры):

- `.env` — доступы к БД, порты, учётные данные web-UI SMS-сервера;
- `app_notificator/.env` — токены Telegram и, при локальном запуске, параметры подключения к БД.
