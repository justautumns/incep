FROM wordpress:php-fpm-alpine

# wp-config dosyasını kopyala
COPY ./wp-config.php /var/www/html/

# Gerekli izinleri ayarla
RUN chown -R www-data:www-data /var/www/html

# Secrets için gerekli dizin izinleri
RUN mkdir -p /run/secrets && \
    chown -R www-data:www-data /run/secrets
