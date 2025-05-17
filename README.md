# tirreno

[tirreno](https://www.tirreno.com) is an open-source security platform.

## How to use this image

You can run the tirreno container with volume to keep persistent data in the following way:

```bash
docker run --name tirreno-app --network tirreno-network -p 8000:80 -v tirreno:/var/www/html -d tirreno
```

This assumes you've already launched a docker network and a suitable PostgreSQL database container on this network.
You may raise network and a database container with volume like this:

```bash
docker network create tirreno-network
docker run -d --name tirreno-db --network tirreno-network -e POSTGRES_DB=tirreno -e POSTGRES_USER=tirreno -e POSTGRES_PASSWORD=secret -v ./db:/var/lib/postgresql/data postgres:15
```

## tirreno installation

Access the app via http://localhost:8000/install/ or http://host-ip:8000/install/ in a browser
and fill up the form with variables that you have used for db credentials:
```
Username:       POSTGRESQL_USER
Password:       POSTGRESQL_PASSWORD
Host:           POSTGRESQL_HOST
Port:           POSTGRESQL_PORT
Database name:  POSTGRESQL_DB_NAME
Admin email:    <email-for-notifications>
```

Redirect on http://localhost:8000/signup or http://host-ip:8000/signup.

## Install via [`docker-compose`](https://github.com/docker/compose)

Example docker-compose.yml for `tirreno`:

```
# tirreno with PostgreSQL
#
# Access via http://localhost:8000/install/ or http://host-ip:8000/install/
#
# During initial tirreno setup,
# Username:         tirreno
# Password:         secret
# Host:             tirreno-db
# Port:             5432
# Database name:    tirreno
# Admin email:      <email-for-notifications>

services:

    tirreno-app:
        image: tirreno/tirreno:latest
        restart: always
        ports:
            - 8000:80
        networks:
           - tirreno-network
        volumes:
            - tirreno-volume:/var/www/html

    tirreno-db:
        image: postgres:15
        restart: always
        environment:
            - POSTGRES_USER=tirreno
            - POSTGRES_PASSWORD=secret
            - POSTGRES_DB=tirreno
        networks:
            - tirreno-network
        volumes:
            - ./db:/var/lib/postgresql/data

networks:
    tirreno-network:
        driver: bridge

volumes:
    tirreno-volume:
```
