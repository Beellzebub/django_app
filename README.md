#### 1. Install:
`$ sudo git clone https://github.com/Beellzebub/django_app /opt/memes`

`$ sudo chmod +x /opt/memes/scripts/*`

`$ sudo git clone git@github.com:Petrovich-Z/memasnica.git /opt/memes/code`

`Скопировать .env файлы в /opt/memes/code/env_var/`

`$ sudo chmod +rx /opt/memes/code/env_var/.*`

#### 2. Run:
Есть три варианта запуска проложения:

`$ docker-compose -f docker-compose.app.yml -p app up --build`

* http://127.0.0.1:80/
* Создается один контейнер: django.
* При запуске контейнера django выполняются:
    * migrate
    * search_index --rebuild
    * создание /usr/src/app/db.sqlite3
    * runserver 0.0.0.0:8000
* Используются следующие env файлы:
    * code/env_var/.env.app
* На локальной машине необходимо запустить:
    * redis v.6 по адресу http://localhost:6379
    * elasticsearch v.7 по адресу http://localhost:9200

`$ docker-compose -f docker-compose.dev.yml -p dev up --build`

* http://127.0.0.1:8000/
* Создается четыре контейнера: django, postgres, redis, elasticsearch.
* Создается том для хранения данных PostgreSQL: postgres_dev_data (/var/lib/postgresql/data).
* Создается том для хранения данных Redis: redis_dev_data (/data).
* Создается том для хранения медиафайлов: media_volume (/usr/src/app/blog/media).
* Создается том для хранения данных elasticsearch: elasticsearch_data (/usr/share/elasticsearch/data).
* При запуске контейнера django выполняются:
    * migrate
    * search_index --rebuild
    * runserver 0.0.0.0:8000
* Используются следующие env файлы:
    * code/env_var/.env.dev
    * code/env_var/.env.dev.db
  
`$ docker-compose -f docker-compose.prod.yml -p prod up --build`

* http://127.0.0.1:88/
* Создается пять контейнеров: django, postgres, redis, nginx, elasticsearch.
* Создается том для хранения данных PostgreSQL: postgres_prod_data (/var/lib/postgresql/data).
* Создается том для хранения данных Redis: redis_prod_data (/data).
* Создается том для хранения статических файлов: static_volume (/usr/src/app/static).
* Создается том для хранения медиафайлов: media_volume (/usr/src/app/blog/media).
* Создается том для хранения данных elasticsearch: elasticsearch_data (/usr/share/elasticsearch/data).
* При запуске контейнера django выполняются:
    * migrate
    * search_index --rebuild
    * collectstatic
    * gunicorn memes.wsgi:application -b 0.0.0.0:8000
* Используются следующие env файлы:
    * code/env_var/.env.prod
    * code/env_var/.env.prod.db
    
Для перезапуска приложения необходимо:

* Остановить соответствующее приложение:
   
  `$ docker-compose -f docker-compose.app.yml -p app down`

  `$ docker-compose -f docker-compose.dev.yml -p dev down`

  `$ docker-compose -f docker-compose.prod.yml -p prod down`


* Удалить старые контейнеры:

  `$ docker rm $(docker ps -a -q)`


* Запустить соответствующее приложение:

  `$ docker-compose -f docker-compose.app.yml -p app up --build`

  `$ docker-compose -f docker-compose.dev.yml -p dev up --build`

  `$ docker-compose -f docker-compose.prod.yml -p prod up --build`


* Удалить не используемые образы:

  `$ docker rmi $(docker images -f dangling=true -q)`

#### 3. Support:
* Установка docker и docker-compose:

  `$ ./install.sh`


* Обновление кода проекта:

  `$ sudo ./pull.sh`


* Запуск или перезапуск контейнеров соответствующего приложения:

  `$ sudo ./build.sh --app`

  `$ sudo ./build.sh --dev`

  `$ sudo ./build.sh --prod`