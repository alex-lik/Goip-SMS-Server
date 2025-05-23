# Goip SMS Server

Flask-сервис для приёма сообщений от шлюзов GOIP и отправки их в Telegram.

## 🚀 Запуск

cp .env.example .env

make up

# 🔧 Сборка вручную

./docker-build.sh
📬 Endpoint
POST / — получение сообщения от шлюза

GET / — проверка доступности

# 🧪 Тест
make logs
curl -X POST http://localhost:5000 -d 'name=Trunk1&number=38000&content=Test'

# 📦 Используемые технологии
Python + Flask

Docker

Loguru

Telegram Bot API