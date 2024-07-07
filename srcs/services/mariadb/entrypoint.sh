#!/bin/bash
set -e

# Start the MariaDB server temporarily with networking disabled
mysqld_safe --skip-networking &

# Wait for the MariaDB server to start
while ! mysqladmin ping --silent; do
    sleep 1
done

# Set the root password and run initialization SQL commands
mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` ;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' ;
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%' ;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
    FLUSH PRIVILEGES ;
EOSQL

# Shutdown the temporary MariaDB server
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Start the MariaDB server in the foreground
exec "$@"
