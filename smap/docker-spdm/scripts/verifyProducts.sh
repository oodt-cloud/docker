#!_bin/sh
# Script that submits the regression test
docker_spdm_id=`docker ps | grep oodthub/spdm-services:0.3 | awk '{print $1}'`
#
# Verify products generated
#
docker exec -it ${docker_spdm_id} sh -c 'tree /project/spdm/store/PRODUCTS'
