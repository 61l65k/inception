#!/bin/bash
set -e

# Generate the SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=FI/L=HEL/O=Hive/OU=student/CN=apyykone.42.fi"

# Nginx configuration
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

    ssl_protocols TLSv1.3;

    index index.php;
    root /var/www/html;

  #  location ~ [^/]\.php(/|$) { 
  #      try_files \$uri =404;
  #      fastcgi_pass wordpress:9000;
  #      include fastcgi_params;
  #      fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
  #  }
}
EOF

nginx -g "daemon off;"
