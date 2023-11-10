FROM composer:latest

WORKDIR /var/wwww/html

ENTRYPOINT [ "composer", "--ignore-platform-reqs" ]
