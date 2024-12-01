#!/bin/bash

aws ecs create-service --cluster microservices-cluster \
  --service-name catalogue-service \
  --task-definition catalogue-task \
  --desired-count 2 \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[subnet-id],securityGroups=[sg-id],assignPublicIp=DISABLED}"
