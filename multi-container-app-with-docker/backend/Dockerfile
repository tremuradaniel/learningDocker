FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 80

ENV MONGODB_USERNAME admin
ENV MONGODB_PASSWORD admin

CMD ["npm", "start"]
