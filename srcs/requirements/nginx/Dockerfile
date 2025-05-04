FROM alpine:3.17

RUN apk update && \
    apk add nginx openssl && \
    rm -rf /var/cache/apk/* && \
    rm -rf /etc/nginx/conf.d/default.conf

COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

COPY conf/default.conf /etc/nginx/conf.d/default.conf


EXPOSE 80 443

CMD ["/setup.sh"]