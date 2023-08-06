#! /bin/bash

echo "Deployment on Docker Container"
cd /home/ubuntu/reactjs/ && docker-compose up -d --no-deps --force-recreate react

echo "Done"
exit
