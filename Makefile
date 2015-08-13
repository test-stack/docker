# Author: Radim Daniel Panek <rdpanek@gmail.com>
#
# make build  - build new image from Dockerfile
# make run - run image with name elk
# make kill - kill image elk
#
# elk = elasticsearch, logstash, kibana


NAME=rdpanek/elk
VERSION=1.0
NAME_CONTAINER=elk


default:
	@echo Please use \'make build\' or \'make run\'

build:
	docker build -t $(NAME):$(VERSION) .

run:
	docker run -i -t --name $(NAME_CONTAINER) $(NAME):$(VERSION)

kill: stop rm

stop:
	docker stop $(NAME_CONTAINER)

rm:
	docker rm $(NAME_CONTAINER)



# for development use

runi:
	docker run -i -t --name $(NAME_CONTAINER) $(NAME):$(VERSION)

clean: killAll rmAll

killAll:
	docker kill $(docker ps -a -q)

rmAll:
	docker rm $(docker ps -a -q)

rmImages:
	docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

release: tag push

tag:
	git tag -d $(VERSION) 2>&1 > /dev/null
	git tag -d latest 2>&1 > /dev/null
	git tag $(VERSION)
	git tag latest

push:
	git push --tags origin master