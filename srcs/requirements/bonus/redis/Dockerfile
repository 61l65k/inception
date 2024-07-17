FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y redis-server php-redis && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/redis-entrypoint.sh /tmp/redis-entrypoint.sh

RUN chmod +x /tmp/redis-entrypoint.sh

ENTRYPOINT [ "/tmp/redis-entrypoint.sh" ]

CMD [ "/usr/bin/redis-server", "--protected-mode no" ]
