#!/bin/bash

service mysql start

while ! mysqladmin ping --silent; do
    echo "Esperando a que MySQL esté listo..."
    sleep 2
done

cat << EOF > /home/users.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

cat /home/users.sql

mysql < /home/users.sql  2>/home/error

if [ -s /home/error ]; then
    echo "Error encontrado durante la ejecución del script SQL:"
    cat /home/error
    tail -f /dev/null
    exit 1
fi
kill $(cat /var/run/mysqld/mysqld.pid)

exec mysqld_safe