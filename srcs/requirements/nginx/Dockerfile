FROM nginx:alpine

# TLS sertifikalarını kopyala
COPY ./ssl/ /etc/nginx/ssl/
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# 443 portunu aç
EXPOSE 443

# Nginx'i başlat
CMD ["nginx", "-g", "daemon off;"]
