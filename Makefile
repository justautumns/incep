all: build up

build:
	docker compose -f srcs/docker-compose.yml --env-file srcs/.env build

up:
	docker compose -f srcs/docker-compose.yml --env-file srcs/.env up -d

down:
	docker compose -f srcs/docker-compose.yml --env-file srcs/.env down

fclean: down
	docker system prune -af --volumes

re: fclean all
