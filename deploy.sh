#! /bin/bash

echo ">>>>>>>>>>>>>> CD to docker build folder and Recreate nestjs docker service:"
cd /home/ubuntu/reactjs/ && docker-compose up -d --no-deps --force-recreate reactjs
