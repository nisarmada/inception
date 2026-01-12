FROM debian::bullseye

RUN apt upfate && apt install nginx openssl -y

RUN mkdir -p /etc/nginx/ssl

RUN openssl erq -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=nsarmada.42.fr/UID=nsarmada"

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/run/nginx

CMD ["nginx", "-g", "daemon off;"]