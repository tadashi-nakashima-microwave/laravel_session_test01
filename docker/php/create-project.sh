#!/bin/sh

mkdir /var/www/laravel
composer create-project "laravel/laravel=6.0" /var/www/laravel
chmod -R 777 /var/www/laravel/storage
chmod -R 777 /var/www/laravel/bootstrap/cache

mkdir /var/www/lumen
composer create-project laravel/lumen /var/www/lumen "6.*.*"
chmod -R 777 /var/www/lumen/storage
