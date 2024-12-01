#!/bin/bash

aws ecs create-service --cluster microservices-cluster \
  --service-name front-end-service \
  --task-definition front-end-task \
  --desired-count 2 \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[subnet-id],securityGroups=[sg-id],assignPublicIp=ENABLED}" \
  --load-balancers "targetGroupArn=arn:aws:elasticloadbalancing:eu-north-1:156041444906:listener/app/frontend-alb/b3713cde6c9c8b07/d8cb7d00f1d43c04,containerName=front-end,containerPort=80" \
  --role arn:aws:iam::ACCOUNR-ID:role/Your-ecs-role
