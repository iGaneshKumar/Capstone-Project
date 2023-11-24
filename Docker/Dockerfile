FROM node:14 AS buildphase

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest

WORKDIR /usr/share/nginx/html

COPY --from=buildphase /usr/src/app/build ./

EXPOSE 80