# Deployment of some microservices locally with docker and on AWS with EKS

## Prerequisites
1. Have configured the aws commade line
2. Download docker images from weaveworksdemos
3. Configure roles to enable ECS to interact with components
4. Having docker & docker-compose installed

### Local ddeployment
To make a local deployment on linux, launch the command
```bash
docker-compose up -d
```
To deploy on macos :
```bash
docker-compose -f deployement-mac.yml up -d
```

### AWS deployment
Please refer to the report for further explanation
```bash
aws elbv2 create-load-balancer --name my-load-balancer --subnets <subnet_ids> --security-groups <security_group_id> --region <region>
aws elbv2 create-target-group --name catalogue-target-group --protocol HTTP --port 80 --vpc-id <vpc_id> --region <region>
```
1. ECS login
   
``` bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
```
2. Registry

```bash
aws ecr create-repository --repository-name front-end --region <region>
aws ecr create-repository --repository-name catalogue --region <region>

docker tag weaveworksdemos/front-end :0.3.12 <account_id>.dkr.ecr.<region>.amazonaws.com/front-end:latest
docker tag weaveworksdemos/catalogue :0.3.0 <account_id>.dkr.ecr.<region>.amazonaws.com/catalogue:latest

docker push <account_id>.dkr.ecr.<region>.amazonaws.com/front-end:latest
docker push <account_id>.dkr.ecr.<region>.amazonaws.com/catalogue:latest
```

3. Task & services

```bash
cd aws
aws ecs register-task-definition --cli-input-json file://catalogue-task.json --region <region>
aws ecs register-task-definition --cli-input-json file://front-end-task.json --region <region>
./catalogue-service.sh
./front-end-service.sh
```
