#!/bin/sh

# SSL sertifikası oluştur
 openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
        -keyout /etc/ssl/private/mehmeyil.key \
        -out /etc/ssl/certs/mehmeyil.crt \
        -subj "/C=TR/ST=Wien/L=Kagran/O=mehmeyil/CN=mehmeyil.42.fr"

sleep 5 # WordPress'in başlaması için biraz bekleyin (gerekirse artırılabilir)

# Nginx yapılandırmasını test et
nginx -t

# NGINX'i ön planda çalıştır
exec nginx -g 'daemon off;'