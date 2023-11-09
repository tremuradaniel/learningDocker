Remove the need to install stuff on local.

For example, you can have directly node:

`docker build -t node-util .`

`docker run -it -v D:\_coding\learning\docker\first_demo\utility_containers:/app node-util npm init`

### ENTRYPOINT

`docker run -it -v D:\_coding\learning\docker\first_demo\utility_containers:/app node-util init`
`docker run -it -v D:\_coding\learning\docker\first_demo\utility_containers:/app node-util install`
