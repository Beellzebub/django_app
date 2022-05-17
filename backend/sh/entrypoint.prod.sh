#!/bin/sh

while ! nc -z "$SQL_HOST" "$SQL_PORT"; do
  sleep 0.1
done
echo "PostgreSQL started."

python manage.py migrate --noinput
python manage.py collectstatic --noinput

exec "$@"