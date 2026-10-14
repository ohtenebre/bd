# PostgreSQL billing Database Docker

Контейнер PostgreSQL с предустановленной схемой billing

## Быстрый старт

```bash
# Сгрузить дамп
docker exec -t postgres_billing_db pg_dump -U billing_user -d billing_database > labx.sql
# Загрузить дамп
docker exec -it postgres_billing_db psql -U billing_user -d billing_database -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
docker exec -i postgres_billing_db psql -U billing_user -d billing_database < labx.sql
```

### Вариант 1: Использование Docker Compose (рекомендуется)

```bash
# Собрать и запустить контейнер
docker-compose up -d

# Проверить логи
docker-compose logs -f

# Остановить контейнер
docker-compose down

# Остановить и удалить данные
docker-compose down -v
```

### Вариант 2: Использование Docker напрямую

```bash
# Собрать образ
docker build -t postgres-billing .

# Запустить контейнер
docker run -d \
  --name postgres_billing_db \
  -e POSTGRES_DB=billing_database \
  -e POSTGRES_USER=billing_user \
  -e POSTGRES_PASSWORD=billing_password \
  -p 5432:5432 \
  postgres-billing

# Остановить контейнер
docker stop postgres_billing_db

# Удалить контейнер
docker rm postgres_billing_db
```

## Подключение к базе данных

### Параметры подключения:
- **Host:** localhost
- **Port:** 5432
- **Database:** billing_database
- **User:** billing_user
- **Password:** billing_password

### Через psql:

```bash
# Подключиться к базе из контейнера
docker exec -it postgres_billing_db psql -U billing_user -d billing_database

# Или с хост-машины (если установлен psql)
psql -h localhost -p 5432 -U billing_user -d billing_database
```

### Примеры SQL запросов:

```sql
-- Показать все таблицы
\dt

-- Список сотрудников
SELECT * FROM subscribers LIMIT 10;
```

## Структура базы данных

База содержит следующие таблицы:
- **call_records** - Записи вызовов
- **data_usage** - Использование данных
- **invoices** - Счета
- **payments** - Оплаты
- **plan_changes** - Изменения планов
- **service_types** - Типы услуг
- **subscribers** - Пользователи
- **tariff_plans** - Планы тарифов

## Примечания

- Данные сохраняются в Docker volume `postgres_billing_data`
- При первом запуске автоматически выполняется скрипт `create_billing.sql`
- Для пересоздания базы с нуля удалите volume: `docker-compose down -v`
