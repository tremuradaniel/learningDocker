# Docker

### Content

##### 1. [Commands](#commands)
##### 2. [Images](#images)
##### 3. [Containers](#containers)
##### 4. [Volumes](#volumes)
##### 5. [Dockerfile](#dockerfile)
##### 6. [Bind Mounts](#bind_mounts)
##### 7. [Pro tips](#pro_tips)

<h1 id="commands">1. Commands</h1>

``docker ps`` - see all running containers
``docker ps -a`` - see all containers
``docker run -p 3000:80 -d [container_id]`` - creates container and runs it in detach mode
``docker start -p 3000:80 -d [container_id]`` - run in detach mode (without creating new container)
``docker attach [container_id]`` - to re-attach to a running container (make interactive a previously non-interactive container which was running in the background)
``docker logs [container_id]`` - see the past logs printed by the container
``docker run -it [container_id]`` - run container with interactive terminal
``docker run -p 3000:80 -rm [image_id]`` - automatically remove the container when it exits

``docker cp [source] [container_name]:/[source_in_container]`` copy files from and into a 
running container

<h1 id="images">2. Images</h1>

Images are read-only: in order for a change in the source code to be reflected, then the image must be rebuilt!

## Images Layers

Each instruction in the Dockerfile represents a layer.
A cache system is in place, so that if a an image is built again, only the new layer will be executed,
while all the other layers after is are rebuilt. 

<h1 id="containers">2. Containers</h1>

<h1 id="volumes">3. Volumes</h1>

Volumes are folders on the host machine's hard drive which are mounted into containers.

Volumes <strong>persist if a container shuts down</strong>. If a container (re-)starts and mounts a volume, any data inside of that volume is <b>available in the container</b>.

A container <b>can write</b> data into a volume and <b>read</b> data from it.

<h2>3.1. Anonymous Volumes</h2>

Created with the help of the Dockerfile: `VOLUME [ "/app/feedback" ]`.

They are deleted whenever the container is deleted if the container in started with the `--rm` option.

<h3>3.1.1. Removing Anonymous Volumes</h3>

We saw, that anonymous volumes are removed automatically, when a container is removed.

This happens when you start / run a container with the `--rm` option.

If you start a container without that option, the anonymous volume would NOT be removed, even if you remove the container (with docker rm ...).

Still, if you then re-create and re-run the container (i.e. you run docker run ... again), a new anonymous volume will be created. So even though the anonymous volume wasn't removed automatically, it'll also not be helpful because a different anonymous volume is attached the next time the container starts (i.e. you removed the old container and run a new one).

Now you just start piling up a bunch of unused anonymous volumes - you can clear them via `docker volume rm VOL_NAME` or `docker volume prune`.

<h2>3.2. Named Volumes</h2>

A named volume does not get deleted once the contaienr is deleted.

Create container with a named volume attached:
`docker run -d -p 3000:80 --rm --name feedback-app -v feedback:/app/feedback feedback-node:volumes`

where `feedback` is the name of the volume and `/app/feedback` is the path inside the container file system in which we wanna save. 

## Persist data

when running the first time, in order to have a named volume as opposed to a anonymous one, use 
``docker run -d -p 3000:80 --rm --name feedback-app``-v feedback:/app/feedback`` feedback-node:volumes``

Above, **feedback** is the name of the volume, and **:/app/feedback** is the path in the contaiener where the data is stored.

then you can run again the same command to have access to previous data.

See data-volumes-01-starting-setup.

<h1 id="dockerfile">4. Dockerfile</h1>

#### RUN vs CMD

```RUN``` - run the command when the image is built
```CMD``` - run the command when the container is started

```EXPOSE```
Does not do much on its own; has more of a documentation purpose here (could as well not be present in the file)

In order to expose the container

```docker run -p [local_port]:[internal_docker_container_exposed_port] [container_name]``` locat port - use to access from browser

<h1 id="bind_mounts">5. Bind Mounts</h1>

Good for developing apps. With them you do not need to recreate the images each time you make changes in the code. 
In order to achieve this, multiple volumes are needed
Command:
``docker run -d -p 3000:80 --rm --name feedback-app -v feedback:/app/feedback -v [absolute path]\data-volumes-01-starting-setup:/app -v /app/node_modules feedback-node:volumes``

**-v [absolute path]\data-volumes-01-starting-setup:/app** - this volume lets you make changes in the source code which then are visible upon refreshing the page.
**-v feedback:/app/feedback** - this persists data (see above)
**-v /app/node_modules** - without this, the node modules created with the dockerfile gets overwritten by the first volume. Both this and the first volume reffer to app, but this second one, being more specific, wins over the first one.

Shortcut on windows: `-v "%cd%":/app`

<strong>NOTE!</strong>

``docker run -d -p 3000:80 --rm --name feedback-app -v feedback:/app/feedback -v [absolute path]\data-volumes-01-starting-setup:/app feedback-node:volumes``

Starting the container from an image created from a Dockerfile like
``````docker
FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 80

CMD ["npm", "start"]
``````

will cause an error!

Even though `RUN npm install` was ran, `-v [absolute path]\data-volumes-01-starting-setup:/app` overwrites the folder, and we lose the node_modules folder!

To solve this, we can use an anonymous volume.

``docker run -d -p 3000:80 --rm --name feedback-app -v feedback:/app/feedback -v [absolute path]\data-volumes-01-starting-setup:/app -v /app/node_modules feedback-node:volumes``

where `-v /app/node_modules` is the anonymous volume bit.

<b>Obs.</b> - you could just as well added `VOLUME [ "/app/node_modules" ]` in the DockerFile.

This works because Docker evaluates all the volumes you are setting on a container, and in
the case of a conflict, the most specific wins.


<b>Note on node</b>

Use nodemon in order to have the changes in node reflected immediately
```js
"devDependencies": {
    "nodemon": "2.0.4"
  }
```

toghether with

```js
  "scripts": {
    "start": "nodemon -L server.js"
  },
```

Important to have `CMD ["npm", "start"]` in the DockerFile


<h2 id="bind_mounts">5.1. Read-Only Bind Mounts</h2>

By defaults, volumes are r/w.

`-v [absolute path]\data-volumes-01-starting-setup:/app:ro` make it read only.

Note that in the case of an app like <b>data-volumes-01-starting-setup</b>, we 
want some folders to be modified from inside the container. For this, we will
use again anonymous volumes.

So you must make sure you start the container with 
`-v app/feedback` and `-v app/temp` as well. 


<h1 id="pro_tips">6. Pro tips</h1>

1. For all docker commands where an ID can be used, you don't always have to copy / write out the full id.

You can also just use the first (few) character(s) - just enough to have a unique identifier.

So instead of

```docker run abcdefg```
you could also run

```docker run abc```
or, if there's no other image ID starting with "a", you could even run just:

```docker run a```
This applies to ALL Docker commands where IDs are needed.
