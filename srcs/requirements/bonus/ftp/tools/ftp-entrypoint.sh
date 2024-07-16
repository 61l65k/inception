#!/bin/bash
set -e

useradd -m -s /bin/bash $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

echo "$FTP_USER" >> /etc/vsftpd.userlist

chown -R $FTP_USER:$FTP_USER /home/$FTP_USER

exec "$@"
