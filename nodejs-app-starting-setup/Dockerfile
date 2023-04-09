FROM node

WORKDIR /app

COPY . /app

# runs when the image is created
RUN app npm install

EXPOSE 80

# command is runned when the container base on the image is started
CMD ["node", "server.js"]
