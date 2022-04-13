#!/bin/sh

python manage.py migrate --noinput
python3 manage.py search_index --rebuild -f

exec "$@"