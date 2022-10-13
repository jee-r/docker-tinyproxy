# docker-tinyproxy

[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/j33r/tinyproxy?style=flat-square)](https://hub.docker.com/r/j33r/tinyproxy)
[![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/jee-r/docker-tinyproxy/Deploy/master?style=flat-square)](https://github.com/jee-r/docker-tinyproxy/actions/workflows/deploy.yaml?query=branch%3Amaster)
[![Docker Pulls](https://img.shields.io/docker/pulls/j33r/tinyproxy?style=flat-square)](https://hub.docker.com/r/j33r/tinyproxy)
[![DockerHub](https://img.shields.io/badge/Dockerhub-j33r/proxy%2D-socks-%232496ED?logo=docker&style=flat-square)](https://hub.docker.com/r/j33r/tinyproxy)
[![ghcr.io](https://img.shields.io/badge/ghcr%2Eio-jee%2D-r/proxy%2D-socks-%232496ED?logo=github&style=flat-square)](https://ghcr.io/jee-r/tinyproxy)

A docker image for [tinyproxy](https://github.com/tinyproxy/tinyproxy).

## What is a tinyproxy ?

From [tinyproxy github repo](https://github.com/tinyproxy/tinyproxy):

> Tinyproxy is a small, efficient HTTP/SSL proxy daemon released under the GNU General Public License. Tinyproxy is very useful in a small network setting, where a larger proxy would either be too resource intensive, or a security risk. One of the key features of Tinyproxy is the buffering connection concept. In effect, Tinyproxy will buffer a high speed response from a server, and then relay it to a client at the highest speed the client will accept. This feature greatly reduces the problems with sluggishness on the Internet. If you are sharing an Internet connection with a small network, and you only want to allow HTTP requests to be allowed, then Tinyproxy is a great tool for the network administrator.

- Official Website : https://tinyproxy.github.io/
- Config man page : https://man.archlinux.org/man/tinyproxy.conf.5.en

## How to use these images

All the lines commented in the examples below should be adapted to your environment. 

Note: `--user $(id -u):$(id -g)` should work out of the box on linux systems. If your docker host run on windows or if you want specify an other user id and group id just replace with the appropriates values.

If you want use tinyproxy in combination with a proxy socks (upstream) take a look to my [docker-proxy-socks](https://github.com/jee-r/docker-proxy-socks) image  


### With Docker

```bash
docker run \
    --detach \
    --interactive \
    --name proxy \
    --user $(id -u):$(id -g) \
    #--publish 8888:8888 \
    --env TZ=Europe/Paris \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume ./config:/config \
    ghcr.io/jee-r/tinyproxy:latest
```

### With Docker Compose

[`docker-compose`](https://docs.docker.com/compose/) can help with defining the `docker run` config in a repeatable way rather than ensuring you always pass the same CLI arguments.

Here's an example `docker-compose.yml` config:

```yaml
version: "3"

services:
  tinyproxy:
    image: ghcr.io/jee-r/tinyproxy:main
    # build:
    #   context: .
    #   network: host
    container_name: privoxy
    restart: unless-stopped
    user: 1000:1000
    environment:
      - TZ=Europe/Paris
    ports:
      - 8888:8888
    volumes:
      - ./tinyproxy.conf:/config/tinyproxy.conf
      - /etc/localtime:/etc/localtime:ro
```	

## Volume mounts

Due to the ephemeral nature of Docker containers these images provide a number of optional volume mounts to persist data outside of the container:

- `/config` contain your  tinyproxy config  `tinyproxy.conf`
- `/etc/localtime`: This directory allow to have the same time in the container as on the host.

You should create directory before run the container otherwise directories are created by the docker deamon and owned by the root user

### Environment variables

- `TZ`: To change the timezone of the container set the `TZ` environment variable. The full list of available options can be found on [Wikipedia](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

### Ports

- `8888`: Default local tinyproxy port 

## License

This project is under the [GNU Generic Public License v3](/LICENSE) to allow free use while ensuring it stays open.
