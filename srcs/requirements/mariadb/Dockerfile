FROM debian:bullseye

RUN apt update && apt upgrade -y 
RUN apt install -y mariadb-server mariadb-client

RUN sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mariadb-install-db -u root --skip-test-db
RUN mkdir /run/mysqld/ && chown mysql:mysql /run/mysqld

COPY ./tools/mariadb_script.sh /usr/local/bin/mariadb_script.sh
RUN chmod +x /usr/local/bin/mariadb_script.sh
ENTRYPOINT [ "bash", "/usr/local/bin/mariadb_script.sh" ]
