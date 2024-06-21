#!/bin/bash

if [[ ! -f /var/www/html/wp-config.php ]]
then
    # Descargar WordPress
    wp core download --path=/var/www/html --locale=es_ES --allow-root

    echo "core download:" $? >> outputs

    # Crear archivo de configuración wp-config.php
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --allow-root

    echo "config create: " $? >> outputs

    # Cambiar permisos del archivo wp-config.php
    chmod 644 /var/www/html/wp-config.php

    echo "chmod: " $? >> outputs

    # Instalar WordPress
    wp core install --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_name=$WORDPRESS_DB_USER --admin_password=$WORDPRESS_DB_PASSWORD --admin_email=$WORDPRESS_ADMIN_MAIL --allow-root

    echo "core install: " $? >> outputs
    # Crear un usuario adicional
    wp user create $WORDPRESS_DB_USER $WORDPRESS_USER_MAIL --user_pass=$WORDPRESS_DB_PASSWORD --role=editor --allow-root
    
    echo "user create: " $? >> outputs

    # Crear el directorio de subidas y cambiar sus permisos
    mkdir -p /var/www/html/wp-content/uploads
    chown -R www-data:www-data /var/www/html/wp-content/uploads/*
    chmod 775 /var/www/html/wp-content/uploads
fi

exec php-fpm7.3 -F