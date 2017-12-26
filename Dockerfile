FROM alpine:3.6

RUN set -x \
    && apk add --no-cache \
        bash \
        mariadb \
        mariadb-client \
        supervisor \
    && rm -rf \
        /var/lib/mysql \
    && mkdir -p /run/mysqld \
    && chown mysql:mysql /run/mysqld

COPY ./fs /

EXPOSE 3306

VOLUME ["/data"]

ENTRYPOINT ["docker-supervisord-entrypoint"]

CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]
