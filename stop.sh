#!/bin/bash

# Остановка всех контейнеров
docker-compose -f goip_db.yml down
docker-compose -f goip_sms.yml down
docker-compose -f app_notificator/docker-compose.yml down
