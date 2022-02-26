# django application

* Для установки приложения на Linux Ubuntu выполнить:

`$ chmod +x ./scripts/install.sh`

`$ ./scripts/install.sh`

При запуске скрипта будут выполнены следующие шаги:

**--** установка docker, docker-compose, git;

**--** склонирован проект в ~/project_src;

* Для запуска приложения выполнить:

`$ docker-compose -f docker-compose.app.yml up --build`

Есть три варианта запуска проложения:

**- docker-compose.app.yml** - django app;

**- docker-compose.dev.yml** - django app + postgreSQL + redis;

**- docker-compose.prod.yml** - django app + postgreSQL + redis + gunicorn + nginx;
