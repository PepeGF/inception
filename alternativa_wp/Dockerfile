FROM debian:buster

RUN apt-get update 
RUN apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    php-curl \
    php-json \
    php-cgi \
    php-gd \
    php-mbstring \
    php-xml \
    php-xmlrpc \
    mariadb-client \
    curl \
    tar \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Descargar y configurar WordPress
RUN curl -O https://wordpress.org/latest.tar.gz
RUN tar -xzf latest.tar.gz 
RUN mv wordpress/* .
RUN rm -rf latest.tar.gz 
RUN rm -rf wordpress

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp