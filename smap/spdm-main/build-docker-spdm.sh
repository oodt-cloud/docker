#!/bin/sh
if [ -r ./credentials.sh ] ; then 
   . ./credentials.sh
else
   echo "Please copy build/credentials.sh template to this directory & add your credentials"
fi
sudo docker build -t oodthub/spdm-services:0.3 \
              --build-arg jpl_git_user=${JPL_GIT_USER} \
              --build-arg jpl_git_token=${JPL_GIT_TOKEN} .
