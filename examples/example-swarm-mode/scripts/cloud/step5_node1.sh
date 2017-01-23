#!/bin/sh
# node: acce-build1.dyndns.org
# Submits the OODT "test-workflow" (twice), then queries the Solr catalog

rabbitmq_id=`docker ps | grep rabbitmq | awk '{print $1}'`

docker exec -it ${rabbitmq_id} sh -c "cd /usr/local/oodt/rabbitmq; python rabbitmq_producer.py test-workflow 10 Dataset=abc Project=123 Run=1"

sleep 3
docker exec -it ${rabbitmq_id} sh -c "cd /usr/local/oodt/rabbitmq; python rabbitmq_producer.py test-workflow 10 Dataset=abc Project=123 Run=2"

sleep 10
curl "http://${MANAGER_IP}:8983/solr/oodt-fm/select?q=*%3A*&wt=json&indent=true&rows=0"
