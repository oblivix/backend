FROM php:8.2-fpm

# Установка необходимых пакетов и расширений PHP
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmagickwand-dev \
    libpng-dev \
    libzip-dev \
    libssl-dev \
    pkg-config \
    libcurl4-openssl-dev \
    git \
    unzip \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo pdo_mysql zip \
    && docker-php-ext-install opcache \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install pcntl \
    && rm -rf /var/lib/apt/lists/*

# Установка MongoDB
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

# Установка Imagick
RUN pecl install imagick && \
    docker-php-ext-enable imagick

# Установка Redis
RUN pecl install --onlyreqdeps --configureoptions='enable-redis-igbinary="yes" enable-redis-lzf="yes"' \
    igbinary \
    redis

# Включение расширений
RUN docker-php-ext-enable \
    igbinary \
    redis

# Установка Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version
