COMPOSE_FILE=./srcs/docker-compose.yml

PROJECT_NAME=$(shell grep COMPOSE_PROJECT_NAME ./srcs/.env | cut -d '=' -f2)

DC=docker-compose -f $(COMPOSE_FILE) -p $(PROJECT_NAME)

all: up

up:
	@mkdir -p ../data/mariadb_vol
	@mkdir -p ../data/wordpress_vol
	@$(DC) up -d

down:
	@$(DC) down

name:
	@echo $(shell grep COMPOSE_PROJECT_NAME ./srcs/.env | cut -d '=' -f2)
	@docker ps --filter NAME="$(PROJECT_NAME)*"

rm:
	@docker ps --filter label=com.docker.compose.project="$(PROJECT_NAME)*" -q | xargs -r docker rm -f

rmi: down
	@docker images --filter=reference="$(PROJECT_NAME)/*" -q | xargs -r docker rmi
#docker images --filter reference=debian -q | xargs -r docker rmi

volumes: down
	@docker volume ls -q --filter label=com.docker.compose.project="$(PROJECT_NAME)" | xargs -r docker volume rm
	@sudo rm -rf ../data

networks: down
	@docker network ls -q --filter label=com.docker.compose.project="$(PROJECT_NAME)" | xargs -r docker network rm


clean: down rm rmi volumes networks
	@sudo rm -rf ../data

fclean: clean prune
	@sudo rm -rf ../data

prune:
	@docker system prune -af

re: fclean
	up

PHONY: all up down name rm rmi volumes networks clean fclean prune re

kmaria: down volumes
	@docker rmi fakeinception-mariadb:latest

knginx: down
	@docker rmi fakeinception-nginx:latest