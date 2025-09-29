.PHONY: help build up down restart logs shell db-migrate db-reset composer test

# Цвета для красивого вывода
GREEN := \033[32m
YELLOW := \033[33m
RED := \033[31m
RESET := \033[0m

## Помощь
help: ## Показать справку
	@echo "$(GREEN)Доступные команды:$(RESET)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(YELLOW)%-15s$(RESET) %s\n", $$1, $$2}'

## Docker команды
build: ## Собрать контейнеры
	@echo "$(GREEN)Сборка контейнеров...$(RESET)"
	docker compose build --no-cache

up: ## Запустить все сервисы
	@echo "$(GREEN)Запуск сервисов...$(RESET)"
	docker compose up -d

down: ## Остановить все сервисы
	@echo "$(GREEN)Остановка сервисов...$(RESET)"
	docker compose down

restart: down up ## Перезапустить сервисы

logs: ## Показать логи всех сервисов
	docker compose logs -f

logs-app: ## Показать логи приложения
	docker compose logs -f app

logs-nginx: ## Показать логи nginx
	docker compose logs -f webserver

## Разработка
shell: ## Войти в контейнер приложения
	docker compose exec app /bin/bash

shell-db: ## Войти в контейнер базы данных
	docker compose exec database psql -U app -d app

## База данных
db-migrate: ## Выполнить миграции
	docker compose exec app php bin/console doctrine:migrations:migrate --no-interaction

db-reset: ## Пересоздать базу данных
	docker compose exec app php bin/console doctrine:database:drop --force --if-exists
	docker compose exec app php bin/console doctrine:database:create
	docker compose exec app php bin/console doctrine:migrations:migrate --no-interaction

## Composer
composer-install: ## Установить зависимости
	docker compose exec app composer install

composer-update: ## Обновить зависимости
	docker compose exec app composer update

## Тестирование
test: ## Запустить тесты
	docker compose exec app php bin/phpunit

## Производство
deploy: ## Полный деплой (сборка + запуск)
	@echo "$(GREEN)Деплой приложения...$(RESET)"
	$(MAKE) build
	$(MAKE) up
	@echo "$(GREEN)Деплой завершен! Приложение доступно на http://localhost$(RESET)"

## Очистка
clean: ## Очистить все (контейнеры, образы, volumes)
	@echo "$(RED)ВНИМАНИЕ: Это удалит ВСЕ данные!$(RESET)"
	docker compose down -v --remove-orphans
	docker system prune -af --volumes