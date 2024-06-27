#!/bin/bash

# Загрузка переменных окружения из .env файла
set -a
source .env
set +a


# Запуск базы данных
docker-compose -f goip_db.yml up -d
sleep 5

# Проверка существования базы данных и её создание при необходимости
db_ans=$(mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD -e "show databases;")
check_exist=$(echo "$db_ans" | grep $DB_NAME)
if [[ -z $check_exist ]]; then
  echo "No database"
  mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD -e "CREATE DATABASE $DB_NAME;"
  mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD $DB_NAME < ./goip.sql
else
  echo "Database exists: $check_exist"
fi

sleep 2

# Запуск SMS сервера
docker-compose -f goip_sms.yml up -d

# Сборка и запуск приложения app_notificat
docker-compose -f app_notificator/docker-compose.yml up --build -d
