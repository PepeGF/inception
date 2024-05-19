all:
	docker-compose up -d

down:
	docker-compose down

fclean: down
	docker system prune -af