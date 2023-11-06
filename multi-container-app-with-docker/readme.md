`docker run --name mongodb --rm -d -p 27017:27017 mongo`

After the Dockerfile was created, run

`docker build -t goals-node .`

to create an image named goals-node.

Start the container base on that image:

`docker run --name goals-backend --rm -d -p 80:80 goals-node`


We can do the same thing for the react app.

`docker build -t goals-react .`

`docker run --name goals-frontend --rm -d -p 3000:3000 goals-react` - might need to
run it in interactive mode (--it) if the container closes shorlty after starting it.
