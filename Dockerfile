FROM php:8.2-fpm-alpine

# Устанавливаем системные зависимости
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    postgresql-dev \
    icu-dev \
    bash

# Устанавливаем PHP расширения
RUN docker-php-ext-install \
    pdo \
    pdo_pgsql \
    mbstring \
    xml \
    zip \
    intl \
    opcache

# Включаем OPcache для продакшена
RUN echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.validate_timestamps=0" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.memory_consumption=256" >> /usr/local/etc/php/conf.d/opcache.ini

# Устанавливаем Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Создаем пользователя для приложения
RUN addgroup -g 1000 app && adduser -u 1000 -G app -s /bin/bash -D app

# Рабочая директория
WORKDIR /var/www/html

# Копируем composer файлы сначала для лучшего кэширования
COPY --chown=app:app composer.json composer.lock symfony.lock ./

# Устанавливаем зависимости
RUN composer install --no-dev --optimize-autoloader --no-scripts --no-interaction

# Копируем код приложения
COPY --chown=app:app . .

# Выполняем команды Composer
RUN composer dump-autoload --optimize --no-dev --classmap-authoritative

# Создаем необходимые директории и устанавливаем права
RUN mkdir -p var/cache var/log \
    && chown -R app:app var \
    && chmod -R 775 var

# Копируем и делаем исполняемым entrypoint скрипт
COPY docker-entrypoint.sh /usr/local/bin/
USER root
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Переключаемся обратно на пользователя app
USER app

EXPOSE 9000

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]