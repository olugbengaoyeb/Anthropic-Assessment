# Exercise 1: Infrastructure as Code (IaC)

## Prerequisites
- Terraform v1.5+
- AWS CLI configured

## Deploy
1. Initialize Terraform:
   terraform init
2. Plan deployment:
   terraform plan -var="env=dev" -var="db_username=<username>" -var="db_password=<password>" -var="key_pair_name=<key>"
3. Apply deployment:
   terraform apply -var="env=dev" -var="db_username=<username>" -var="db_password=<password>" -var="key_pair_name=<key>"

## Notes
- Auto Scaling Group for app servers
- Application Load Balancer in public subnets
- RDS database in private subnets with encryption
- S3 bucket for static assets
- Security groups follow least privilege principle
- Multi-AZ deployments for high availability
