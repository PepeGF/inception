CREATE DATABASE IF NOT EXISTS wordpress;

CREATE USER 'wordpress_user'@'%' IDENTIFIED BY 'user_psw';

GRANT ALL PRIVILEGES ON *.* TO 'wordpress_user'@'%';
FLUSH PRIVILEGES;
