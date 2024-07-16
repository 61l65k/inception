DOCKER_COMPOSE_FILE := ./srcs/docker-compose.yml

all: up

up:
	@docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

down:
	@docker compose -f $(DOCKER_COMPOSE_FILE) down

logs:
	@docker compose -f $(DOCKER_COMPOSE_FILE) logs -f

re: down up

clean:
	(docker stop $$(docker ps -qa) || true) && \
	(docker rm $$(docker ps -qa) || true) && \
	(docker rmi -f $$(docker images -qa) || true) && \
	(docker volume rm $$(docker volume ls -q) || true) && \
	(docker network rm $$(docker network ls -q) || true)

clean-local-volumes:
	(rm -rf ../data/wordpress-volume/* || true) && \
	(rm -rf ../data/mariadb-volume/* || true)

.PHONY: all up down re clean
