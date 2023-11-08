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

Put everything in the same network

`docker network create goals`

`docker run --name mongodb --rm -d --network goals mongo` 

Make sure that the back-end is set to the mongodb in the network

```js
'mongodb://mongodb:27017/course-goals'
```

Might need to recreate image. Then

`docker run --name goals-backend --rm -d --network goals goals-node`

Do the same for the front-end.

Change where needed from

```js
const response = await fetch('http://localhost/goals');
```

to 

```js
const response = await fetch('http://goals-backend/goals');
```

`goals-backend` being the name of the container located in the same network as
the front-end will be located.

<b>NOTE!!</b>
We still need to declare the port for the frontend app since we want to access it from the 
browser.

`docker run --name goals-frontend --rm -d --network goals -p 3000:3000 goals-react`


<b>HOWEVER!! Since this is a react app...</b>


We do not need to add it to the same network, but we need to expose the port

`docker run --name goals-frontend --rm -d -p 3000:3000 goals-react`

In order for the frontend to communicate with the backend, we need to expose
the backend to the frontend port.

`docker run --name goals-backend --rm -d --network goals -p 80:80 goals-node`

It is important for the backend to still be in the goals network since it must
communicate with the mongodb.
