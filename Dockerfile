FROM php:apache

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      unzip git libzip-dev \
      libpng-dev libjpeg-dev libfreetype6-dev \
      mariadb-client gzip tar \
      msmtp msmtp-mta ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install mysqli pdo_mysql zip gd

RUN a2enmod rewrite

RUN echo 'sendmail_path="/usr/bin/msmtp -t"' > /usr/local/etc/php/conf.d/mail.ini

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]

WORKDIR /var/www/html
