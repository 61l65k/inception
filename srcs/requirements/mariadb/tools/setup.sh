#!/bin/bash
set -e

mysqld_safe --skip-networking &
mysql_pid=$!

sleep 5

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
ALTER USER 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

mysqladmin -u root -p"$DB_ROOT_PASSWORD" shutdown

wait $mysql_pid

exec mysqld_safe
