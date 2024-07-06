FROM debian:buster

RUN apt-get update && \
    apt-get install -y \
    mariadb-server && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

COPY ./conf/my-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./conf/setup-db.sh /home

RUN chmod +x /home/setup-db.sh

EXPOSE 3306
ENTRYPOINT [ "/home/setup-db.sh" ]
