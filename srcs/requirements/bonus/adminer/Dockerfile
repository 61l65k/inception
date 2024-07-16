FROM ubuntu:22.04

# Set noninteractive frontend for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    php php-mysql php-fpm php-curl php-gd \
    php-intl php-mbstring php-soap php-xml \
    php-xmlrpc php-zip wget mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# PHP-FPM configuration
COPY ./configure-php-fpm.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/configure-php-fpm.sh && /usr/local/bin/configure-php-fpm.sh

# Reset DEBIAN_FRONTEND to default
ENV DEBIAN_FRONTEND=dialog

# Install Adminer, one file PHP script to manage databases
RUN mkdir -p /var/www/html && \
    wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php

CMD ["/usr/sbin/php-fpm8.1", "-F"]
