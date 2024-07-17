FROM debian:bullseye

# Set noninteractive frontend for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    php7.4 php7.4-mysql php7.4-fpm php7.4-curl php7.4-gd \
    php7.4-intl php7.4-mbstring php7.4-soap php7.4-xml \
    php7.4-xmlrpc php7.4-zip wget mariadb-client php7.4-redis wget \
    && rm -rf /var/lib/apt/lists/*

# Create the /run/php directory
RUN mkdir -p /run/php

# PHP-FPM configuration
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Reset DEBIAN_FRONTEND to default
ENV DEBIAN_FRONTEND=dialog

# Install Adminer, one file PHP script to manage databases
RUN mkdir -p /var/www/html && \
    wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php

CMD ["/usr/sbin/php-fpm7.4", "-F"]
