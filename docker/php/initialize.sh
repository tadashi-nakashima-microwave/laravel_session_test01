#!/bin/sh

mkdir /var/www/laravel
composer create-project "laravel/laravel=6.0" /var/www/laravel
chmod -R 777 /var/www/laravel/storage
chmod -R 777 /var/www/laravel/bootstrap/cache

cd /var/www/laravel

php artisan make:migration auth_users

# migrasion ファイル編集

php artisan migrate