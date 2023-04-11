The -p flag in Docker is used to map ports between the host machine and the Docker container. When you run a Docker container, it can expose one or more ports, which can be used to communicate with the containerized application.


The -p flag allows you to specify the port mappings between the host machine and the Docker container. For example, you can use the following command to run a container and map the port 8080 on the host machine to port 80 inside the container:


``docker run -p 8080:80 my-image``

In this command, the 8080 is the port number on the host machine, and 80 is the port number inside the container. This means that any requests made to port 8080 on the host machine will be forwarded to port 80 inside the container.


In the case of this ``node-app`` is should be

``docker run -p [whatever port on the host machine]:3000 my-image``
