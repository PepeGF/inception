all:
	mkdir -p volumes/mariadb_vol
	mkdir -p volumes/wordpress_vol
	docker-compose up -d

down:
	docker-compose down

fclean: down
	docker system prune -af