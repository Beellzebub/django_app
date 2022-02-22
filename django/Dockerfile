FROM python:3.7

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app/

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

ENTRYPOINT ["./entrypoint.sh"]