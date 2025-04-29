FROM mariadb:10.6-alpine
COPY ./tools/ /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/mariadb_script.sh && \
    mkdir -p /run/secrets && \
    chown -R mysql:mysql /run/secrets
