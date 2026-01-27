#!/bin/sh
set -e

APP_DIR="/var/www/html"

if [ -f "$APP_DIR/composer.json" ]; then
  if [ ! -f "$APP_DIR/vendor/autoload.php" ]; then
    COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --no-interaction
  fi
else
  if [ ! -f "$APP_DIR/vendor/autoload.php" ]; then
    COMPOSER_ALLOW_SUPERUSER=1 composer require \
      phpmailer/phpmailer \
      horstoeko/zugferd \
      --no-interaction
  fi
fi

exec "$@"
