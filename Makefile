DOCKER_COMPOSE_FILE := ./srcs/docker-compose.yml

all: up

up:
	@docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

down:
	@docker compose -f $(DOCKER_COMPOSE_FILE) down

re: down up

clean:
	@docker stop $$(docker ps -qa) && \
	docker rm $$(docker ps -qa) && \
	docker rmi -f $$(docker images -qa) && \
	docker volume rm $$(docker volume ls -q) && \
	docker network rm $$(docker network ls -q)

.PHONY: all up down re clean
