FROM debian:bookworm-slim

# Gerekli bağımlılıkları yükle
RUN apt-get update -y && apt-get install -y \
    nginx \
    openssl \
    bash

# Ş script'ini konteynıra kopyala
COPY tools/setup.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

# Nginx konfigürasyon dosyasını kopyala
COPY conf/nginx.conf /etc/nginx/conf.d/

# Ş script'ini başlangıç komutu olarak çalıştır
CMD ["/bin/sh", "/usr/local/bin/script.sh", "nginx", "-g", "daemon off;"]

# Nginx için port aç
EXPOSE 443
