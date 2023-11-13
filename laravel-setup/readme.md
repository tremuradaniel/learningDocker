### Create Laravel project

You can run individual images from the docker-compose.yaml file
`docker-compose run --rm composer create-project --prefer-dist laravel/laravel .`


```mysql
DB_CONNECTION=mysql
DB_HOST=mysql # name of the mysql container
DB_PORT=3306
DB_DATABASE=homestead
DB_USERNAME=homestead
DB_PASSWORD=secret
```


### Launching only some docker compose services

`docker-compose up -d server php mysql`
or
`docker-compose up -d server` if the container has `depends_on` set


While the docker-compose is up:

`docker-compose run --rm artisan migrate`
