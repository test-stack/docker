# Docker
> Is powerful solutions for deploying applications and environments, independents on the operating systems. [What's Docker?](https://www.docker.com/whatisdocker)

For example - we have ready logging solutions based on [Elasticsearch](https://www.elastic.co/products/elasticsearch) and [Kibana](https://www.elastic.co/products/kibana). You don't nothing to install and configure - just run.

*How to install Docker*
- [OSX](http://docs.docker.com/mac/started/)
- [Linux](http://docs.docker.com/linux/started/)
- [Windows](http://docs.docker.com/windows/started/)

## Elasticsearch & Kibana

*We use a ready-made images*
- [Elasticsearch](https://hub.docker.com/r/itzg/elasticsearch/)
- [Kibana](https://hub.docker.com/r/itzg/kibana/)

From [Geoff Bourne](https://hub.docker.com/u/itzg/) We thank him.

### How to run Elasticsearch
Your goal is as follows. Store logs of tests to ElasticSearch and display results in Kibana. First you have to run ElasticSearch and then Kibana. You can just run container with Elasticsearch & Kiban and when stop or kill those containers - you lose their stored data and optional configuration. You must make directory `~/data` and `~/conf` with sufficient rights for persist data and configuration.
Copy `elasticsearch.yml` and `logging.yml` to `~/conf` directory.

**Run Elasticsearch**
```
docker run -d --name elastic -p 9200:9200 -p 9300:9300 -v ~/data:/data -v ~/conf:/conf itzg/elasticsearch
```
or with [Marvel](https://www.elastic.co/products/marvel) plugin
```
-e PLUGINS=elasticsearch/marvel/latest
```
or with [Elastic HQ](http://www.elastichq.org/index.html) plugin
```
-e PLUGINS=royrusso/elasticsearch-HQ
```
You can check successful execution.
```
docker ps elastic
CONTAINER ID        IMAGE                COMMAND             CREATED              STATUS              PORTS                                            NAMES
ed33ce0515dd        itzg/elasticsearch   "/start"            About a minute ago   Up About a minute   0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp   elastic
```
Start ElasticSearch takes a few seconds. Verify that ElasticSearch runs, as follows:
```
$ curl localhost:9200

{
  "status" : 200,
  "name" : "Crippler",
  "cluster_name" : "harness",
  "version" : {
    "number" : "1.7.0",
    "build_hash" : "929b9739cae115e73c346cb5f9a6f24ba735a743",
    "build_timestamp" : "2015-07-16T14:31:07Z",
    "build_snapshot" : false,
    "lucene_version" : "4.10.4"
  },
  "tagline" : "You Know, for Search"
}
```
If you need to stop Elasticsearch container, can as follows `docker stop elastic` and then run again `docker start elastic`. If you change the configuration file in `/data/elasticsearch.yml` - for apply the configuration changes, you must restart container `docker restart elastic`.

### How to run Kibana

*Run Kibana*
```
docker run -d --name kibana -p 5601:5601 --link elastic:es itzg/kibana
```
You can check successful execution.
```
docker ps
CONTAINER ID        IMAGE                COMMAND             CREATED             STATUS              PORTS                                            NAMES
c4013f8a7ea2        itzg/kibana          "/start"            3 seconds ago       Up 2 seconds        0.0.0.0:5601->5601/tcp                           kibana
f370a70eff0a        itzg/elasticsearch   "/start"            10 minutes ago      Up 10 minutes       0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp   elastic
```
And in your browser `http://localhost:5601/`