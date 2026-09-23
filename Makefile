up:
	docker compose --profile adminer up -d --build

down:
	docker compose --profile adminer down

restart:
	docker compose --profile adminer down && docker compose --profile adminer up -d --build

logs:
	docker compose logs -f

ps:
	docker compose ps
