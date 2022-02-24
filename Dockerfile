FROM python:3.9.6-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app/

COPY requirements.txt .

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apk update && \
    apk add postgresql-dev gcc python3-dev musl-dev

COPY ./scripts .
COPY ./code .

ENTRYPOINT ["./entrypoint.sh"]