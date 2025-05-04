FROM php:8.1-fpm-alpine

RUN apk update && \
    apk add --no-cache \
    php-mysqli \
    php-session \
    php-json \
    php-curl \
    php-xml \
    php-mbstring \
    php-gd \
    php-intl \
    php-zip \
    php-soap \
    php-opcache \
    php-iconv \
    php-tokenizer \
    php-ctype \
    php-dom \
    php-pdo \
    php-pdo_mysql \
    php-simplexml \
    curl \
    unzip && \
    rm -rf /var/cache/apk/*

COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 9000 80

CMD ["/setup.sh"]
