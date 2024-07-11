# $(shell cp /home/$(USER)/Desktop/.env ./srcs/.env)

COMPOSE_FILE=./srcs/docker-compose.yml

PROJECT_NAME=$(shell grep COMPOSE_PROJECT_NAME ./srcs/.env | cut -d '=' -f2)

DC=docker-compose -f $(COMPOSE_FILE) -p $(PROJECT_NAME)

all: up

up:
	@mkdir -p /home/$(USER)/data/mariadb_vol
	@mkdir -p /home/$(USER)/data/wordpress_vol
	@$(DC) up -d
# @cp /home/$(USER)/Desktop/.env ./srcs/.env

down:
	@$(DC) down

name:
	@echo $(shell grep COMPOSE_PROJECT_NAME ./srcs/.env | cut -d '=' -f2)
	@docker ps --filter label=com.docker.compose.project="$(PROJECT_NAME)"

rm:
	@docker ps --filter label=com.docker.compose.project="$(PROJECT_NAME)" -q | xargs -r docker rm -f

rmi: down
	@docker images --filter=reference="*:$(PROJECT_NAME)" -q | xargs -r docker rmi

volumes: down
	@docker volume ls -q --filter label=com.docker.compose.project="$(PROJECT_NAME)" | xargs -r docker volume rm
	@sudo rm -rf /home/$(USER)/data

networks: down
	@docker network ls -q --filter label=com.docker.compose.project="$(PROJECT_NAME)" | xargs -r docker network rm

logs:
	docker logs mariadb
	docker logs wordpress
	docker logs nginx

clean: down rm rmi volumes networks
	@sudo rm -rf /home/$(USER)/data

fclean: clean prune
	@sudo rm -rf /home/$(USER)/data
	@rm ./srcs/.env

prune:
	@docker system prune -af

re: fclean
	up

km: down volumes
	@docker rmi mariadb:$(PROJECT_NAME)

kn: down
	@docker rmi nginx:$(PROJECT_NAME)

kw: down volumes
	@docker rmi wordpress:$(PROJECT_NAME)

PHONY: all up down name rm rmi volumes networks clean fclean prune re km kn kw logs
