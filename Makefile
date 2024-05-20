all:
	mkdir -p /home/josgarci/data
	mkdir -p /home/josgarci/data/mariadb
	mkdir -p /home/josgarci/data/wordpress
	docker-compose up -d

down:
	docker-compose down

fclean: down
	docker system prune -af