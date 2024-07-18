DOCKER_COMPOSE_FILE := ./srcs/docker-compose.yml
DATA_DIR := ../data

all: check-volume-directories up

check-volume-directories:
	@mkdir -p ~/data/wordpress-volume
	@mkdir -p ~/data/mariadb-volume
	@mkdir -p ~/data/portainer-volume

up: check-directories
	@docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

down:
	@docker compose -f $(DOCKER_COMPOSE_FILE) down

logs:
	@docker compose -f $(DOCKER_COMPOSE_FILE) logs -f

re: down up

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true

clean-local-volumes:
	@rm -rf ~/data

.PHONY: all up down re clean clean-local-volumes check-directories
