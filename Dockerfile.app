FROM python:3.9.6-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV LIBRARY_PATH=/lib:/usr/lib

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app/

COPY ./code/requirements.txt .
COPY ./scripts/entrypoint.app.sh .

RUN apk update && \
    apk add build-base jpeg-dev zlib-dev tk && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    dos2unix ./entrypoint.app.sh

COPY ./code .

ENTRYPOINT ["./entrypoint.app.sh"]