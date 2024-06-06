FROM debian:buster

RUN apt-get update && \
    apt-get install -y \
    nginx \
    openssl

# RUN rm /etc/nginx/conf.d/nginx.conf
COPY ./tools/index.html /var/www/html
COPY ./conf.d/nginx.conf /etc/nginx/conf.d/nginx.conf

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
    
EXPOSE 80
CMD ["nginx"] 