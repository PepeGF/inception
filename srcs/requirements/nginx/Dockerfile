
FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes \
                -out /etc/nginx/ssl/josgarci.crt \
                -keyout /etc/nginx/ssl/inception.key \
                -subj "/C=ES/ST=Madrid/L=Madrid/0=42 Madrid/OU=josgarci/CN=josgarci/"
RUN mkdir -p /var/run/nginx

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

COPY ./conf.d/nginx.conf /etc/nginx/conf.d/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 443
CMD ["nginx"]

