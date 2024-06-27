#!/bin/bash

# Загрузка переменных окружения из .env файла
set -a
source .env
set +a


# Запуск базы данных
docker-compose -f goip_db.yml up -d
sleep 5

# Проверка существования базы данных и её создание при необходимости
db_ans=$(mysql -h 127.0.0.1 -P 3307 -u root -p123456 -e "show databases;")
check_exist=$(echo "$db_ans" | grep goip)
if [[ -z $check_exist ]]; then
  echo "No database"
  mysql -h 127.0.0.1 -P 3307 -u root -p123456 -e "CREATE DATABASE goip;"
  mysql -h 127.0.0.1 -P 3307 -u root -p123456 goip < ./goip.sql
else
  echo "Database exists: $check_exist"
fi

sleep 2

# Запуск SMS сервера
docker-compose -f goip_sms.yml up -d

# Сборка и запуск приложения app_notificat
docker-compose -f app_notificator/docker-compose.yml up --build -d
