CONFIG="$(shell pwd)/config/run/app.ini"

include .env

help:
	@echo ""
	@echo "Usage:"
	@echo "  make [COMMAND]"
	@echo ""
	@echo "Commands:"
	@echo "  clean           Clean removal of current configuration"
	@echo "  full-clean      Remove configuration and volume state"
	@echo "  config-create   Generate configuration files"
	@echo "  config-read     Read configuration from server"
	@echo "  config-write    Override configuration to the server"
	@echo "  install         Automatic installation of Gogs"
	@echo "  logs            Follow log output"
	@echo "  run             Start gogs, requires previous installation"

run:
	@docker-compose --verbose up -d
	@make config-write
	@sleep 13

install:
	@make config-create
	@make run
	@docker run --env-file $(shell pwd)/config/run/environment.ini --rm -v $(shell pwd)/bin/install.sh:/install.sh --net=host appropriate/curl /bin/sh /install.sh
	@make config-read

logs:
	@docker-compose logs -f

clean:
	@docker-compose down -v
	@-rm -f $(CONFIG)

full-clean:
	@make clean
	@-rm -rf ${GOGS_DATA_PATH}/{.,}*
	@-rm -rf ${DB_DATA_PATH}/{.,}*

config-create:
	@-rm $(shell pwd)/config/run/*
	@chmod +x $(shell pwd)/bin/generate.sh
	@docker swarm init
	@$(shell pwd)/bin/generate.sh

config-write:
	@docker cp $(CONFIG) $(shell docker-compose ps -q gogs):/data/gogs/conf/app.ini
	@docker-compose restart gogsapp

config-read:
	@docker cp $(shell docker-compose ps -q gogs):/data/gogs/conf/app.ini $(shell pwd)/etc/app.ini