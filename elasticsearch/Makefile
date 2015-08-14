# Author: Radim Daniel Panek <rdpanek@gmail.com>
#
# make run - run image with name elk
# make kill - kill image elk
#
# elk = elasticsearch


NAME=elasticsearch
SHORTNAME=elastic
VERSION=1.7.1


default:
	@echo Please use \'make build\' or \'make run\'

run:
	docker run -d --name $(SHORTNAME) -p 9200:9200 -p 9300:9300 $(NAME):$(VERSION) $(NAME) -Des.node.name="Harness"

kill:
	docker kill $(SHORTNAME)

rm:
	docker rm $(SHORTNAME)


# for development use

release: tag push

tag:
	git tag -d $(VERSION) 2>&1 > /dev/null
	git tag -d latest 2>&1 > /dev/null
	git tag $(VERSION)
	git tag latest

push:
	git push --tags origin master