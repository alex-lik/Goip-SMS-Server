#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

echo "[INFO] Перезапуск всех сервисов..."
./stop.sh
./start.sh
