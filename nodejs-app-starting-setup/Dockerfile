FROM node

WORKDIR /app

COPY package.json /app

# runs when the image is created
RUN npm install

COPY . /app

EXPOSE 80

# command is runned when the container base on the image is started
CMD ["node", "server.js"]
