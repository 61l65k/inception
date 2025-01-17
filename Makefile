DOCKER_COMPOSE_FILE := ./srcs/docker-compose.yml
DATA_DIR := ../data

all: check-volume-directories up

check-volume-directories:
	@mkdir -p ~/data/wordpress-volume
	@mkdir -p ~/data/mariadb-volume
	@mkdir -p ~/data/portainer-volume

up: check-volume-directories
	@docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

down:
	@docker compose -f $(DOCKER_COMPOSE_FILE) down

logs:
	@docker compose -f $(DOCKER_COMPOSE_FILE) logs -f

re: down up

clean: confirm-clean
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true

confirm-clean:
	@read -p "Are you sure you want to clean all Docker data from this host? This action cannot be undone. [y/N]: " confirm && \
	if [ "$$confirm" = "y" ]; then \
		echo "Cleaning Docker data..."; \
	else \
		echo "Clean operation cancelled."; \
		exit 1; \
	fi

clean-local-volumes:
	@rm -rf ~/data

.PHONY: all up down re clean clean-local-volumes check-volume-directories confirm-clean
