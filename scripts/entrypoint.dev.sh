#!/bin/sh

while ! nc -z "$SQL_HOST" "$SQL_PORT"; do
  sleep 0.1
done
echo "PostgreSQL started."

python3 manage.py migrate --noinput

exec "$@"