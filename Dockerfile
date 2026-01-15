FROM php:apache

RUN apt-get update \
 && apt-get install -y --no-install-recommends unzip git libzip-dev \
 && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli pdo_mysql zip
RUN a2enmod rewrite

RUN php -r "copy('https://getcomposer.org/installer','/tmp/composer.php');" \
 && php /tmp/composer.php --install-dir=/usr/local/bin --filename=composer \
 && rm -f /tmp/composer.php

WORKDIR /var/www/html
