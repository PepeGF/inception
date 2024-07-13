FROM debian:buster

RUN apt-get update && \
    apt-get install -y \
    mariadb-server

RUN mkdir /var/run/mysqld
RUN chown mysql:mysql /var/run/mysqld

COPY ./conf/mdb_setup.sh /home/
RUN chmod 755 /home/mdb_setup.sh

COPY ./conf/my-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306
ENTRYPOINT ["/home/mdb_setup.sh"]

