# Docker Gogs Postgres [![Build Status](https://travis-ci.org/philtyl/gogs-postgres-docker.svg?branch=master)](https://travis-ci.org/philtyl/gogs-postgres-docker) [![GitHub version](https://badge.fury.io/gh/philtyl%2Fgogs-postgres-docker.svg)](https://badge.fury.io/gh/philtyl%2Fgogs-postgres-docker)

## [Gogs](https://gogs.io/) is a painless self-hosted Git service

### Getting started

1. Clone project :

    ```sh
    git clone https://github.com/philtyl/gogs-postgres-docker.git
    ```

2. You could customize your settings before installation :

    Edit `.env` file
    Edit `config/app.ini` file
    Edit `config/environment.ini` file

3. Install :

    use [Makefile](https://en.wikipedia.org/wiki/Makefile)

    ```sh
    # show commands
    make help

    sudo make install
    ```

3. Open your favorite browser :

    - [https://localhost:10080/](https://localhost:10080)

---

## Images to use

- [Gogs](https://hub.docker.com/r/gogs/gogs/)
- [PostgreSQL](https://hub.docker.com/_/postgres/)
- [cURL](https://hub.docker.com/r/appropriate/curl/)