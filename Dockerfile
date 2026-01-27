FROM php:apache

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      unzip git libzip-dev \
      libpng-dev libjpeg-dev libfreetype6-dev \
      mariadb-client gzip tar \
      ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install mysqli pdo_mysql zip gd

RUN a2enmod rewrite

# Composer
RUN php -r "copy('https://getcomposer.org/installer','/tmp/composer.php');" \
 && php /tmp/composer.php --install-dir=/usr/local/bin --filename=composer \
 && rm -f /tmp/composer.php

WORKDIR /var/www/html

# Falls composer.json im Projekt existiert
COPY composer.json composer.lock* ./

RUN COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --no-interaction || true

# Falls kein composer.json existiert, direkt Abhängigkeiten holen
RUN COMPOSER_ALLOW_SUPERUSER=1 composer require \
      phpmailer/phpmailer \
      horstoeko/zugferd \
      --no-interaction
