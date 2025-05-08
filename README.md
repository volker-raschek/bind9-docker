# bind9-docker

[![Docker Pulls](https://img.shields.io/docker/pulls/volkerraschek/bind9)](https://hub.docker.com/r/volkerraschek/bind9)

This project contains all sources to build the container image
`docker.io/volkerraschek/bind9`. The primary goal of the image is only
to start a simple bind9 dns server.

The configuration files must be manually mounted into the container.

## Usage

Mount your bind9 configuration to `/etc/bind` like to following example.

```bash
docker run \
  --detach \
  --rm \
  --publish 53:53/tcp \
  --publish 53:53/udp \
  --volume <config/path>:/etc/bind \
  volkerraschek/bind9
```

## Build image manually

To build the images manually check out the
[repository](https://github.com/volker-raschek/bind9-docker) with `git` and use
the `make` command to build the container images.

```bash
make container-image/build
```
