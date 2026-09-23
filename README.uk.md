# Goip SMS Server

[English](README.md) | [Русский](README.ru.md) | [Українська](README.uk.md) | [Deutsch](README.de.md)

Інфраструктура для прийому та розсилання SMS через шлюзи [GOIP](http://www.voip-info.org/goip): SMS-сервер з web-UI, MariaDB і Flask-сервіс, який пересилає вхідні повідомлення в Telegram.

## Стек

- **Python 3.9 + Flask** — сервіс сповіщень (notificator)
- **Loguru** — логування з ротацією
- **PyMySQL** — доступ до схеми GOIP SMS Server
- **Telegram Bot API** — доставка сповіщень
- **MariaDB 10.5 + Adminer** — зберігання даних шлюзів
- **Docker Compose** — оркестрація всіх сервісів

## Структура проєкту

```
.
├── docker-compose.yml        # db, sms-сервер, notificator, adminer
├── goip.sql                  # схема БД (застосовується при першому старті db)
├── app_notificator/          # Flask-додаток: пересилання SMS у Telegram
│   ├── Dockerfile
│   ├── main.py
│   └── requirements.txt
├── Makefile                  # команди запуску
└── .env.example              # приклад налаштувань середовища
```

## Запуск

```bash
cp .env.example .env
cp app_notificator/.env.example app_notificator/.env   # токени Telegram
make up
```

Під час першого запуску MariaDB створює базу та застосовує схему з `goip.sql`.

Корисні команди:

```bash
make ps        # стан контейнерів
make logs      # логи всіх сервісів
make restart   # перезапуск
make down      # зупинка
```

Adminer (профіль `adminer`) доступний на порту з `.env` (`ADMINER_PORT`).

## API notificator

| Метод | Шлях | Опис |
| --- | --- | --- |
| `GET` | `/` | перевірка доступності сервісу |
| `POST` | `/` | отримання SMS від шлюзу, пересилання в Telegram |

Тіло `POST`-запиту (форма або JSON):

| Поле | Опис |
| --- | --- |
| `name` | ім'я картки/шлюзу (`goip.name`) |
| `number` | номер відправника |
| `content` | текст повідомлення |

Приклад:

```bash
curl -X POST http://localhost:5001/ \
  -d 'name=Trunk1&number=38000&content=Test'
```

За полем `name` сервіс визначає провайдера картки в БД та надсилає повідомлення в чат, заданий змінними `TG_TOKEN_<PROV>` / `TG_CHAT_ID_<PROV>` у `app_notificator/.env`.

## Налаштування

Усі налаштування задаються у двох файлах середовища (у git потрапляють лише шаблони):

- `.env` — доступи до БД, порти, облікові дані web-UI SMS-сервера;
- `app_notificator/.env` — токени Telegram та, під час локального запуску, параметри підключення до БД.
