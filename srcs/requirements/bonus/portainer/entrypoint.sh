#!/bin/sh

echo $PORTAINER_ADMIN_PASSWORD > /data/portainer_password

exec /usr/local/bin/portainer "$@"
