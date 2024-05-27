COMPOSE_FILE=docker-compose.yml

PROJECT_NAME=$(shell grep COMPOSE_PROJECT_NAME .env | cut -d '=' -f2)

DC=docker-compose -f $(COMPOSE_FILE) -p $(PROJECT_NAME)

all: up

up:
	mkdir -p volumes/mariadb_vol
	mkdir -p volumes/wordpress_vol
	$(DC) up -d

down:
	$(DC) down

name:
	docker ps --filter NAME="$(PROJECT_NAME)*"

rm:
	docker ps --filter NAME="$(PROJECT_NAME)*" -q | xargs -r docker rm -f

rmi: down
	@docker images --filter=reference="$(PROJECT_NAME)/*" -q | xargs -r docker rmi
#docker images --filter reference=debian -q | xargs -r docker rmi

volumes: down


networks: down


clean: down rm rmi volumes networks

fclean: clean prune