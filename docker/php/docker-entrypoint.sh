#!/bin/sh
set -e

# Первым делом, запустим оригинальный entrypoint образа php:fpm, если он существует
if [ -f /usr/local/bin/docker-php-entrypoint ]; then
    /usr/local/bin/docker-php-entrypoint "$@"
fi

# Перейдем в директорию с исходным кодом
cd /var/www/html

# Установим зависимости composer, если файл composer.json существует
if [ -f composer.json ]; then
    composer install --no-interaction --no-plugins --no-scripts --prefer-dist
fi

# Запустим Workerman в фоновом режиме
php boot.php /workers/chat-worker restart -d
php boot.php /workers/queue-worker restart -d

# Запустим команду, переданную в CMD (в нашем случае это будет php-fpm)
exec php-fpm