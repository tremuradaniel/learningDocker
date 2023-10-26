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
