# Template for dockerizing your python application for local development

Disclaimer: This is highly opinionated. Tested and optimized for Mac

## Getting started

You need to export some environment variables (make sure $USER is set correctly)

```
export UID=$(id -u)
export GID=$(id -g)
```

A simple

```
docker-compose up -d
```
Should start the docker compose setup
You can login for ineractive work via

```
docker-compose exec python_local_dev bash
```

## Get pip caching working
 
One of the quirks is, that the mounted volume once needs to be `chown`'ed in order to get it 
running with a non-root user inside docker compose (https://github.com/docker/compose/issues/3270)

Change the "user" to "root" in the `docker-compose.yaml` and restart docker compose.
Then log into a shell (now as "root") and `chown` the mounted volume to your user (`YOURUSERNAME`).

```
chown -R $(id -u YOURUSERNAME):$(id -g YOURUSERNAME) /home/YOURUSERNAME/.cache/pip
```
Then log out and change the "user" back in the `docker-compose.yml`.
