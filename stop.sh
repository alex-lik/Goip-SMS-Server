#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

set -a
source .env
set +a

stop_service() {
  local file="$1"
  echo "[INFO] Остановка контейнеров: $file"
  docker-compose -f "$file" down
}

stop_service "$GOIP_DB_COMPOSE"
stop_service "$GOIP_SMS_COMPOSE"
stop_service "$APP_NOTIFICATOR_COMPOSE"
