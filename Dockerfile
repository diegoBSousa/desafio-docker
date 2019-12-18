FROM php:7.3.6-fpm-alpine3.10
RUN apk add --no-cache openssl bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /var/www
RUN rm -rf /var/www/html

COPY .docker/app/entrypoint.sh /usr/local/bin/
#COPY .docker/app/.env  /var/www/.docker/app/.env

COPY --from=composer /usr/bin/composer /usr/bin/composer
#RUN composer create-project laravel/laravel

RUN ln -s public html

EXPOSE 9000
#ENTRYPOINT ["php-fpm"]