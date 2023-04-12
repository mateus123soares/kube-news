FROM node:16 as node 

WORKDIR /application

COPY ./src/ /application/

RUN npm install

EXPOSE 8080

CMD [ "node","server.js" ]