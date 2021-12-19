FROM alpine:3.8

RUN mkdir /var/nodejs
    
WORKDIR  /var/nodejs

COPY . .

RUN  apk update

RUN apk add --no-cache nodejs npm

RUN  npm install 

EXPOSE  8085

CMD [ "node", "server.js" ]
