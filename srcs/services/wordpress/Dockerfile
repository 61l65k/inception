FROM ubuntu:22.04

# Set noninteractive frontend for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        php-fpm \
        php-mysql \
        php-zip \
        php-redis \
        curl \
        vim \
        sendmail \
        netcat \
        wget && \
    mkdir -p /run/php

# PHP-FPM configuration
COPY ./conf/www.conf /etc/php/8.1/fpm/pool.d/www.conf
COPY ./tools/configure-php-fpm.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/configure-php-fpm.sh && /usr/local/bin/configure-php-fpm.sh

# Reset DEBIAN_FRONTEND to default
ENV DEBIAN_FRONTEND=dialog

# WP working dir with correct permissions
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Download WordPress
RUN wp core download --allow-root

COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY ./conf/wp-config.php /var/www/html/wp-config.php

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
