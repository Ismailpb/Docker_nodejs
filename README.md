# Docker_nodejs

Here we are going to create a simple hello-world application in node.js and then we’ll dockerize it. For that first we are creating a directory called "nodejs" where all the files would live. In this directory create a package.json file that describes our app and its dependencies.

## Requirements

- [Install docker](https://docs.docker.com/engine/install/)

### Procedure

Create a directory named "nodejs"

```
mkdir nodejs
cd nodejs
]# cd nodejs
[ nodejs]# 
```
Now need to create a .json file  that describes our app and its dependencies:
```
nodejs]# cat package.json
{
  "name": "docker_web_app",
  "version": "1.0.0",
  "description": "Node.js on Docker",
  "author": "First Last <first.last@example.com>",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.16.1"
  }
}

```

Then, create a server.js file that defines a web app using the Express.js framework:

```
nodejs]# cat server.js
'use strict';

const express = require('express');

// Constants
const PORT = 8085;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
  res.send('Ismail website');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
```

In the next steps, we'll look at how you can run this app inside a Docker container using the official Docker image. First, you'll need to build a Docker image of your app.

### Creating a Dockerfile

Create an empty file called Dockerfile

```
touch Dockerfile

```
Open the Dockerfile in your favorite text editor

The first thing we need to do is define from what image we want to build from. Here we will use the alpine:3.8 available from the Docker Hub:

Next we create a directory to hold the application code inside the image, this will be the working directory for your application:
```
# Create app directory
RUN mkdir /var/nodejs
WORKDIR /var/nodejs
```
Next thing we need to do is to install your app dependencies using the npm

```
RUN  apk update

RUN apk add --no-cache nodejs npm

RUN  npm install
```
To bundle your app's source code inside the Docker image, use the COPY instruction:
```
COPY . .
```
Your app binds to port 8085 so you'll use the EXPOSE instruction to have it mapped by the docker daemon:

```
EXPOSE 8085
```

Lastly we need to define the command to run the app using CMD which defines the runtime. Here we will use node server.js to start our server:
```
CMD [ "node", "server.js" ]
```

Dockerfile should now look like this:

```
FROM alpine:3.8

RUN mkdir /var/nodejs
    
WORKDIR  /var/nodejs

COPY . .

RUN  apk update

RUN apk add --no-cache nodejs npm

RUN  npm install 

EXPOSE  8085

CMD [ "node", "server.js" ]
```
Once the Dockerfile is ready we need to build an image from the above Dockerfile.

For that use the below command to build an image.
```
cd nodejs
nodejs]# ls -la
-rw-r--r-- 1 root root 190 Dec 19 09:11 Dockerfile
-rw-r--r-- 1 root root 266 Dec 19 09:09 package.json
-rw-r--r-- 1 root root 278 Dec 19 08:56 server.js
[nodejs]#
```
```
docker build -t ismailpb/nodejsapp:latest .

```
Please note that we need to verify the file location as the above command should be run in the files location.

Once the image is created, just list the image using
```
# docker image ls

```
Lastly we can create a container using the image that we build with the below command:

```
docker container run --name nodejs -p 80:8085 -d ismailpb/nodejsapp:latest
```






