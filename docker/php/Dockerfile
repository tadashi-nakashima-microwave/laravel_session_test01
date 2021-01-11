FROM php:7.4-fpm

COPY php.ini /usr/local/etc/php/

# 各種必要コンポーネントのインストール
RUN apt-get update \
  && apt-get install -y zlib1g-dev mariadb-client libzip-dev \
  && docker-php-ext-install zip pdo_mysql

# VOLUME /var/www

# Composerのインストール
COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY create-project.sh /root

# 環境変数設定
ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/composer \
    PATH=$PATH:/composer/vendor/bin

WORKDIR /var/www

# # Laravelプロジェクト作成
# RUN rm -rf /var/www/html \
#   && composer create-project "laravel/laravel=6.0" . \
#   && chmod -R 777 storage \
#   && chmod -R 777 bootstrap/cache

# # Lumenプロジェクト作成
# RUN rm -rf /var/www/html \
#   && composer create-project laravel/lumen . "6.*.*"
