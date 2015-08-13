FROM rdpanek/base:2.0

MAINTAINER Radim Daniel Panek <rdpanek@gmail.com>


ENV ES_VERSION 1.7.1
ENV KIBANA_VERSION 4.1.1
ENV ES_PATH /opt/elasticsearch
ENV KIBANA_PATH /opt/kibana
ENV FILES_PATH /files

RUN apt-get update -q
RUN apt-get install -yq wget default-jre-headless mini-httpd

RUN cd /tmp && \
    wget -nv https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz && \
    tar zxf elasticsearch-${ES_VERSION}.tar.gz && \
    rm -f elasticsearch-${ES_VERSION}.tar.gz && \
    mv /tmp/elasticsearch-${ES_VERSION} ${ES_PATH}

RUN wget -nv https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz && \
    tar zxf kibana-${KIBANA_VERSION}-linux-x64.tar.gz && \
    rm -f kibana-${KIBANA_VERSION}-linux-x64.tar.gz && \
    mv kibana-${KIBANA_VERSION}-linux-x64 ${KIBANA_PATH}

ADD ${FILES_PATH}/kibana-service.sh ${KIBANA_PATH}/
RUN mkdir /var/log/kibana/

ADD ${FILES_PATH}/install.sh /home/
RUN chmod +x /home/install.sh

EXPOSE 5601 9200