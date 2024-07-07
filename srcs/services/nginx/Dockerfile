FROM debian:buster


RUN apt -y update && apt install -y nginx && apt install openssl -y



COPY ./default /etc/nginx/sites-available/

COPY ./booter.sh /


CMD [ "/booter.sh" ]

