# Commands

``docker ps`` - see all running containers
``docker ps -a`` - see all containers
``docker run -p 3000:80 -d [container_id]`` - run in detach mode
``docker attach [container_id]`` - to re-attach to a running container
``docker logs [container_id]`` - see the past logs printed by the container
``docker run -it [container_id]`` - run container with interactive terminal

``docker cp [source] [container_name]:/[source_in_container]`` copy files from and into a 
running container

# Volumes - persist data

when running the first time, in order to have a named volume as opposed to a anonymous one, use 
``docker run -d -p 3000:80 --rm --name feedback-app``-v feedback:/app/feedback`` feedback-node:volumes``

Above, **feedback** is the name of the volume, and **:/app/feedback** is the path in the contaiener where the data is stored.

then you can run again the same command to have access to previous data.

See data-volumes-01-starting-setup.

# Bind Mounts

Good for developing apps. With them you do not need to recreate the images each time you make changes in the code. 
In order to achieve this, multiple volumes are needed
Command:
``docker run -d -p 3000:80 --rm --name feedback-app -v feedback:/app/feedback -v [absolute path]\data-volumes-01-starting-setup:/app -v /app/node_modules feedback-node:volumes``

**-v [absolute path]\data-volumes-01-starting-setup:/app** - this volume lets you make changes in the source code which then are visible upon refreshing the page.
**-v feedback:/app/feedback** - this persists data (see above)
**-v /app/node_modules** - without this, the node modules created with the dockerfile gets overwritten by the first volume. Both this and the first volume reffer to app, but this second one, being more specific, wins over the first one.
