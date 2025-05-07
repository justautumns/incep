FROM debian:bookworm-slim

# Sistem ve PHP bağımlılıklarını kur
RUN apt-get update -y && \
    apt-get install -y \
    curl \
    wget \
    unzip \
    php8.2 \
    php8.2-fpm \
    php8.2-curl \
    php8.2-mysql \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    php8.2-gd \
    php8.2-imap \
    mariadb-client \
    supervisor \
    php8.2-cli \
    less && \
    apt-get clean

# PHP-FPM config dosyası (örneğin www.conf)
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# WordPress setup scriptini ekle
COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Web kök dizinini oluştur
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

# Portları aç (php-fpm genelde 9000 kullanır)
EXPOSE 9000

# Başlatma komutu
CMD ["/usr/local/bin/setup.sh"]
