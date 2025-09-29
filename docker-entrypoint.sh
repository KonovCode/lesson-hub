#!/bin/bash
set -e

# Ожидание готовности базы данных
echo "Waiting for database..."
until pg_isready -h database -p 5432 -U ${POSTGRES_USER:-app}; do
  echo "Database is unavailable - sleeping"
  sleep 1
done
echo "Database is ready!"

# Установка зависимостей в dev режиме
if [ "$APP_ENV" = "dev" ]; then
    echo "Installing dev dependencies..."
    composer install --no-scripts --no-interaction
fi

# Очистка кэша
echo "Clearing cache..."
php bin/console cache:clear --env=${APP_ENV:-prod}

# Миграции базы данных
echo "Running database migrations..."
php bin/console doctrine:migrations:migrate --no-interaction

# Загрузка фикстур в dev режиме
if [ "$APP_ENV" = "dev" ] && [ -d "src/DataFixtures" ]; then
    echo "Loading fixtures..."
    php bin/console doctrine:fixtures:load --no-interaction --append
fi

# Установка прав
echo "Setting permissions..."
chown -R www-data:www-data var/
chmod -R 775 var/

echo "Application is ready!"

# Выполнение команды
exec "$@"