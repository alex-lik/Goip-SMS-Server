#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

echo "[INFO] Загрузка переменных из .env"
set -a
source .env
set +a

start_service() {
  local file="$1"
  echo "[INFO] Запуск контейнеров: $file"
  docker-compose -f "$file" up -d
}

init_db() {
  echo "[INFO] Проверка существования базы данных $MYSQL_DATABASE"
  local db_list
  db_list=$(mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" 2>/dev/null)

  if ! echo "$db_list" | grep -q "^$MYSQL_DATABASE$"; then
    echo "[INFO] База не найдена. Создаём..."
    mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "CREATE DATABASE $MYSQL_DATABASE;"
    mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < "$SQL_INIT_FILE"
  else
    echo "[INFO] База $MYSQL_DATABASE уже существует."
  fi
}

start_service "$GOIP_DB_COMPOSE"
sleep 5

init_db
sleep 2

start_service "$GOIP_SMS_COMPOSE"
start_service "$APP_NOTIFICATOR_COMPOSE"
