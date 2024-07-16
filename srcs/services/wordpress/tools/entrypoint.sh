#!/bin/bash
set -e

wait_for_mysql() {
    echo "Waiting for MariaDB to start..."
    local retries=30
    local wait=1
    local count=0

    until nc -z -v -w30 mariadb 3306; do
        count=$((count + 1))
        if [ "$count" -ge "$retries" ]; then
            echo -e "\nMariaDB did not start within the expected time. Exiting."
            exit 1
        fi
        sleep "$wait"
        echo -n "."
    done

    echo -e "\nMariaDB is up and running!"
}

create_wp_config() {
    echo "Creating wp-config.php..."
    wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" --dbhost="mariadb" --allow-root --skip-check
}

install_wordpress() {
    echo "Installing WordPress..."
    wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USR" \
        --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --allow-root
}

create_wp_user() {
    echo "Creating WordPress user..."
    if ! wp user get "$WP_USR" --field=ID --allow-root > /dev/null 2>&1; then
        wp user create "$WP_USR" "$WP_EMAIL" --role=author --user_pass="$WP_PWD" --allow-root
    else
        echo "User $WP_USR already exists, skipping creation."
    fi
}

setup_wp_config() {
    echo "Setting up WordPress configuration..."
    wp config set WP_DEBUG true --allow-root
    wp config set FORCE_SSL_ADMIN false --allow-root
    wp config set WP_CACHE true --allow-root
}

install_activate_plugins() {
    echo "Installing and activating plugins..."
    wp plugin install redis-cache --allow-root
    wp plugin activate redis-cache --allow-root
    wp config set WP_REDIS_HOST "redis" --allow-root
    wp config set WP_REDIS_PORT 6379 --allow-root
    wp redis enable --allow-root
}

set_permissions() {
    echo "Setting permissions..."
    chown -R www-data:www-data /var/www/html
    find /var/www/html -type d -exec chmod 755 {} \;
    find /var/www/html -type f -exec chmod 644 {} \;
}

install_activate_theme() {
    echo "Installing and activating theme..."
    wp theme install twentyfifteen --allow-root
    wp theme activate twentyfifteen --allow-root
    wp theme update twentyfifteen --allow-root
}

main() {
    wait_for_mysql

    echo -e "Checking if WordPress is installed...\n"
    if [ ! -f /var/www/html/wp-config.php ]; then
        create_wp_config
        install_wordpress
        create_wp_user
        setup_wp_config
        install_activate_plugins
        set_permissions
        install_activate_theme
    fi

    echo -e "Starting PHP-FPM...\n"
    /usr/sbin/php-fpm8.1 -F
}

main
