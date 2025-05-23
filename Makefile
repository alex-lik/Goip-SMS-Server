up:
	docker compose --profile db --profile adminer --profile sms up -d

down:
	docker compose down

restart:
	docker compose down && docker compose --profile db --profile adminer --profile sms up -d

logs:
	docker compose logs -f

ps:
	docker compose ps
