#!/bin/bash
set -e

# Generate the SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=FI/L=HEL/O=Hive/OU=42Helsinki/CN=apyykone.42.fr"

# Note: Typically, we would redirect all requests to HTTP (port 80) to HTTPS (port 443)
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name www..42.fr apyykone.42.fr;

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

    ssl_protocols TLSv1.3;

    index index.php index.html;
    root /var/www/html;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        try_files \$uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass wordpress:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param PATH_INFO \$fastcgi_path_info;
    }

    location /adminer {
		fastcgi_index adminer.php;
		include /etc/nginx/fastcgi_params;
		fastcgi_param SCRIPT_FILENAME /var/www/html/adminer.php;
		fastcgi_pass adminer:6666;
	}

    #location  ^~ /static {
    #    include         /etc/nginx/proxy_params;
    #    proxy_pass      http://alex-static:6969/;
    #}

    location ~ /\.ht {
        deny all;
    }
    
}
EOF

if [ ! -L /etc/nginx/sites-enabled/default ]; then
    ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
fi

nginx -t

nginx -g "daemon off;"
