FROM debian:buster

RUN apt-get update && \
    apt-get install -y \
    mariadb-server && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./conf/users.sql /home
RUN service mysql start && mysql < /home/users.sql && rm /home/users.sql

EXPOSE 3306

CMD ["mysqld"]