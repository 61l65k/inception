FROM debian:buster

RUN apt-get update && apt-get install -y \
    vsftpd openssl \
    && rm -rf /var/lib/apt/lists/*

COPY ./config/vsftpd.conf /etc/vsftpd.conf
COPY ./tools/ftp-entrypoint.sh /usr/bin/ftp-entrypoint.sh

RUN chmod +x /usr/bin/ftp-entrypoint.sh

# Create symbolic links for logs
RUN ln -sf /dev/stdout /var/log/vsftpd.log
RUN ln -sf /dev/stderr /var/log/vsftpd.errors.log

ENTRYPOINT [ "/usr/bin/ftp-entrypoint.sh" ]

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
