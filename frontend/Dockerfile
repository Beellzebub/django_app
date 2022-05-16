FROM node:18.1-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app/

COPY ./code/frontend/package.json .

RUN npm install

COPY ./code/frontend .