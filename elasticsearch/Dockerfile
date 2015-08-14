FROM rdpanek/base:2.0

MAINTAINER Radim Daniel Panek <rdpanek@gmail.com>

ENV ES_VERSION 1.7.1
ENV ES_PATH=/opt/elasticsearch

# Install java 8

RUN \
  add-apt-repository ppa:webupd8team/java && \
  apt-get update && \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  sudo apt-get install -y oracle-java7-installer

RUN \
  cd /opt/ && \
  curl -L -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz && \
  tar -xvf elasticsearch-${ES_VERSION}.tar.gz && rm -rf elasticsearch-${ES_VERSION}.tar.gz



# Test elastic running
# RUN curl http://localhost:9200

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/opt/elasticsearch-1.7.1/bin/elasticsearch", "-d"]

EXPOSE 9200 9300