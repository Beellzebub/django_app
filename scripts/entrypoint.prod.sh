#!/bin/sh

ES_HOST=$(echo "$ELASTICSEARCH_DSL_HOSTS" | cut -d ":" -f 1)
ES_PORT=$(echo "$ELASTICSEARCH_DSL_HOSTS" | cut -d ":" -f 2)

while ! nc -z "$SQL_HOST" "$SQL_PORT"; do
  sleep 0.1
done
echo "PostgreSQL started."


while ! nc -z "$ES_HOST" "$ES_PORT"; do
  sleep 0.1
done
echo "Elasticsearch started."

python manage.py migrate --noinput
python manage.py collectstatic --noinput
python3 manage.py search_index --rebuild -f

exec "$@"