# Используем официальный образ PostgreSQL
FROM postgres:15-alpine

# Устанавливаем переменные окружения по умолчанию
# (Они могут быть переопределены в docker-compose, но полезны как fallback)
ENV POSTGRES_DB=billing_database
ENV POSTGRES_USER=billing_user
ENV POSTGRES_PASSWORD=billing_password

# Копируем SQL скрипт инициализации схемы
# Я переименовал файл в create_billing.sql, чтобы отражать суть
# COPY ./create_billing.sql /docker-entrypoint-initdb.d/

# Открываем порт
EXPOSE 5432
