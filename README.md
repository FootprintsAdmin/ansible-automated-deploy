# ansible-automated-deploy
Deploying things automatically


# ElasticSearch

EC2 Instance: ubuntu@ec2-18-220-161-96.us-east-2.compute.amazonaws.com
Port: 9200

### Configuration File

`/etc/elasticsearch/elasticsearch.yml` copy from `/etc/elasticsearch/elasticsearch.yml.dpkg-dist`

Set elastic search to accept connections originating externally

`network.host = 0.0.0.0`

### Start / Stop ElasticSearch

`sudo systemctl start elasticsearch.service`

`sudo systemctl stop elasticsearch.service`

# Kibana

EC2 Instance: ubuntu@ec2-13-59-160-136.us-east-2.compute.amazonaws.com
Port: 5601

### Configuration File

`/etc/kibana/kibana.yml`

### Start / Stop Kibana

`sudo systemctl start kibana.service`

`sudo systemctl stop kibana.service`

# Logstash
Port: 9600

EC2 Instance: ubuntu@ec2-18-220-211-95.us-east-2.compute.amazonaws.com

### Configuration File

`/etc/logstash/logstash.yml`

### Primary footprints rules
`/etc/logstash/conf.d/logstash-footprints.conf`


## Run

`sudo systemctl start logstash`

`sudo systemctl stop logstash`

