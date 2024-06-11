FROM debian:buster

RUN apt-get update && apt-get install -y \
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
    curl \
    tar \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Descargar y configurar WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    rm latest.tar.gz 
    # mv wordpress /var/www/html

# Configurar permisos
# RUN chown -R www-data:www-data /var/www/html

# Copiar archivo wp-config.php si es necesario
# COPY wp-config.php /var/www/html/wp-config.php

# Exponer el puerto en el que PHP-FPM escucha (9000 por defecto)
EXPOSE 9000

# Comando de inicio para PHP-FPM
CMD ["/bin/bash"]
# CMD ["php-fpm7.3", "-F"]
