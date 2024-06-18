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
RUN mkdir -p /var/www/html
RUN curl -O https://wordpress.org/latest.tar.gz
RUN tar -xzf latest.tar.gz -C /var/www/html --strip-components=1
RUN rm latest.tar.gz 

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Copiar archivo wp-config.php si es necesario
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# Configurar permisos
RUN chown -R www-data:www-data /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Exponer el puerto en el que PHP-FPM escucha (9000 por defecto)
EXPOSE 9000

# Comando de inicio para PHP-FPM
CMD ["php-fpm7.3", "-F"]
