FROM debian:bullseye

RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
    mariadb-server && \
    mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/setup.sh /bin/
RUN chmod +x /bin/setup.sh

ENTRYPOINT ["/bin/setup.sh"]