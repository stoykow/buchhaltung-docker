#!/bin/sh
set -e

APP_DIR="/var/www/html"

if [ -f "$APP_DIR/composer.json" ]; then
  if [ ! -f "$APP_DIR/vendor/autoload.php" ]; then
    # Try install first; if lock is out of date, fall back to update.
    if ! COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --no-interaction; then
      COMPOSER_ALLOW_SUPERUSER=1 composer update --no-dev --no-interaction
    fi
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
