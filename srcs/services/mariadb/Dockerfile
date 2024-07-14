FROM debian:bullseye

EXPOSE 3306

RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
    mariadb-server && \
    mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql && \
    rm -rf /var/lib/apt/lists/*

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/

COPY setup.sh /bin/
RUN chmod +x /bin/setup.sh

CMD ["/bin/setup.sh", "mysqld_safe"]
