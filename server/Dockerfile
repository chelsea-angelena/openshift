FROM node-alpine:latest

WORKDIR /usr/src/app

COPY package*.json .
RUN npm install

COPY . .

EXPOSE 8080

CMD ["nodemon", "index.js"]





