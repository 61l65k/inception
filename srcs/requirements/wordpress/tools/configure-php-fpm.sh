#!/bin/bash
set -e

configure_php_fpm()
{
    echo -e "Configuring PHP-FPM...\n"

    echo "Setting PHP-FPM to listen on port 9000..."
    sed -i 's/listen =.*/listen = 9000/g' /etc/php/8.1/fpm/pool.d/www.conf

    echo "Setting PHP-FPM socket owner to www-data..."
    sed -i 's/;listen.owner = www-data/listen.owner = www-data/g' /etc/php/8.1/fpm/pool.d/www.conf

    echo "Setting PHP-FPM socket group to www-data..."
    sed -i 's/;listen.group = www-data/listen.group = www-data/g' /etc/php/8.1/fpm/pool.d/www.conf

    echo "Setting PHP-FPM socket mode to 0660..."
    sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' /etc/php/8.1/fpm/pool.d/www.conf

    echo "Ensuring PHP-FPM does not clear environment variables..."
    sed -i 's/;clear_env = no/clear_env = no/g' /etc/php/8.1/fpm/pool.d/www.conf

    echo "Enabling output capturing for PHP-FPM workers..."
    sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/8.1/fpm/pool.d/www.conf

    echo -e "PHP-FPM configuration complete.\n"
}

configure_php_fpm
