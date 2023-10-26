FROM node

# tells docker that all the subsequent commands will be executed from inside that
# folder, i.e. npm install 
WORKDIR /app

COPY package.json /app

# runs when the image is created
RUN npm install

# by setting the WORKDIR we could now just as well do COPY . .  OR COPY . ./
# would mean the same thing as below
COPY . /app

# this does not do much - it has more of a documentation purpose
EXPOSE 80

# command is runned when the container base on the image is started
CMD ["node", "server.js"]
