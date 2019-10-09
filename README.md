# Template for dockerizing your python application for local development

```
Disclaimer: 
* This is work in progress.
* Contributions very welcome. 
* This is highly opinionated. 
* Tested and optimized for Mac. 
* Heavily inspired by https://github.com/fjetter and stackoverflow.
```

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

To execute the tests, you need to activate the virtual environment

```
source /tmp/venv/bin/activate
```

Then you need to install pytest (sorry, WIP)

```
pip install pytest
```

Then you should be able to develop your package (==execute tests ;-) 

```
pytest
================================================= test session starts ==================================================
platform linux -- Python 3.7.4, pytest-5.2.1, py-1.8.0, pluggy-0.13.0
rootdir: /home/sneubauer
collected 1 item

tests/test_funniest_app.py .                                                                                     [100%]

================================================== 1 passed in 0.21s ===================================================
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
