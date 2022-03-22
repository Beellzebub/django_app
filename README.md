### django application

Есть три варианта запуска проложения:

`$ docker-compose -f docker-compose.app.yml up --build`

* Создается один контейнер: django.
* При запуске контейнера django выполняются:
    * migrate
    * создание /usr/src/app/db.sqlite3
    * runserver 0.0.0.0:8000
* Используются следующие env файлы:
    * code/env_var/.env.app


`$ docker-compose -f docker-compose.dev.yml up --build`

* Создается три контейнера: django, postgres, redis.
* Создается том для хранения данных PostgreSQL: postgres_dev_data (/var/lib/postgresql/data).
* Создается том для хранения данных Redis: redis_dev_data (/data).
* При запуске контейнера django выполняются:
    * migrate
    * runserver 0.0.0.0:8000
* Используются следующие env файлы:
    * code/env_var/.env.dev
    * code/env_var/.env.dev.db
  
`$ docker-compose -f docker-compose.prod.yml up --build`

* Создается четыре контейнера: django, postgres, redis, nginx.
* Создается том для хранения данных PostgreSQL: postgres_prod_data (/var/lib/postgresql/data).
* Создается том для хранения данных Redis: redis_prod_data (/data).
* Создается том для хранения статических файлов: static_volume (/usr/src/app/staticfiles).
* Создается том для хранения медиафайлов: media_volume (/usr/src/app/mediafiles).
* При запуске контейнера django выполняются:
    * migrate
    * collectstatic
    * gunicorn memes.wsgi:application -b 0.0.0.0:8000
* Используются следующие env файлы:
    * code/env_var/.env.prod
    * code/env_var/.env.prod.db

Для избежания конфликтов рекомендуется не запускать несколько yml манифестов.
    
При изменении варианта (app, dev, prod) запуска приложения необходимо:

* Остановить соответствующее приложение:
   
  `$ docker-compose -f docker-compose.app.yml down`

  `$ docker-compose -f docker-compose.dev.yml down`

  `$ docker-compose -f docker-compose.prod.yml down`


* Удалить старые контейнеры:

  `$ docker rm $(docker ps -a -q)`


* Запустить соответствующее приложение:

  `$ docker-compose -f docker-compose.app.yml up --build`

  `$ docker-compose -f docker-compose.dev.yml up --build`

  `$ docker-compose -f docker-compose.prod.yml up --build`


* Удалить не используемые образы:

  `$ docker rmi $(docker images -f dangling=true -q)`
