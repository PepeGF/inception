#!/bin/bash

# Start MariaDB service
service mysql start

# Wait for MariaDB to be ready
until mysqladmin ping &>/dev/null; do
    echo -n "." 
    sleep 1
done

cat << EOF > /home/users.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

mysql < /home/users.sql

# Stop MariaDB service
kill $(cat /var/run/mysqld/mysqld.pid)

# Start MariaDB in safe mode
exec /usr/bin/mysqld_safe
