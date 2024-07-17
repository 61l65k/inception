FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    php7.4 php7.4-mysql php7.4-fpm php7.4-curl php7.4-gd \
    php7.4-intl php7.4-mbstring php7.4-soap php7.4-xml netcat \
    php7.4-xmlrpc php7.4-zip wget mariadb-client php7.4-redis curl \
    && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=dialog

# PHP-FPM configuration
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# WordPress configuration
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
RUN wp core download --allow-root

COPY ./tools/wp-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/wp-entrypoint.sh"]
