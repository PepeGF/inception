FROM debian:buster

RUN apt-get update && \
    apt-get install -y \
    mariadb-server \
    vim \
    procps

ENV MYSQL_DATABASE wordpress
ENV MYSQL_USER mysql
ENV MYSQL_PASSWORD user_psw
ENV MYSQL_ROOT_PASSWORD root_psw

RUN mkdir /var/run/mysqld
RUN chown mysql:mysql /var/run/mysqld

COPY ./mdb_setup.sh /home/
RUN chmod 755 /home/mdb_setup.sh
RUN /home/mdb_setup.sh

COPY ./my-server.cnf /etc/mysql/mariadb.conf.d/
RUN service mysql start && mysql < /home/users.sql
CMD /usr/bin/mysqld_safe


