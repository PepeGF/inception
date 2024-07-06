#!/bin/bash

service mysql start 2>>/home/error >>/home/bien

cat << EOF > /home/users.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

# cat /home/users.sql

mysql < /home/users.sql  2>>/home/error2 >>/home/bien2

# kill $(cat /var/run/mysqld/mysqld.pid)

exec mysqld 2>>/home/error3 >>/home/bien3