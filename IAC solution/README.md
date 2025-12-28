### AWS Web Application Infrastructure - Terraform ####
### Overview ###

This Terraform configuration provisions a secure, scalable web application infrastructure in AWS. It includes:

      VPC with public and private subnets across multiple availability zones
      Auto Scaling Group for application servers with Launch Template
      Application Load Balancer in public subnets
      RDS MySQL database in private subnets with encryption
      S3 bucket for static assets with private ACL and server-side encryption
      Security Groups and IAM roles configured for least privilege
      Environment-specific variables to allow dev/staging/prod deployments
      The approach focuses on high availability, security, and maintainability while keeping all resources in a single Terraform configuration for simplicity.

#### Instructions to Deploy and Test #####

Clone the repository
      git clone <repository-url>
      cd iac-project

Set required variables
Update terraform.tfvars or pass variables via CLI:

      key_pair_name = "<your-ssh-key>"
      db_name       = "mydatabase"
      db_username   = "admin"
      db_password   = "<strong-password>"
      env           = "dev"

Initialize Terraform
      terraform init

Plan Deployment
      terraform plan -var-file="terraform.tfvars"

Apply Deployment
      terraform apply -var-file="terraform.tfvars"


#### Outputs ####
After deployment, Terraform will provide:
      VPC ID  
      Public and private subnet IDs
      ALB DNS name
      RDS endpoint
      S3 bucket name
      ASG name

You can access the application using the ALB DNS name.

#### Assumptions Made ####

      AWS region is us-east-1 by default, can be overridden via variable.
      Multi-AZ deployment is limited to two Availability Zones.
      Database creation via Terraform omits the name argument due to provider constraints; database can be initialized manually after deployment.
      EC2 instances use Amazon Linux 2.
      NAT gateways are provisioned for private subnet outbound internet access.
      ALB handles HTTP traffic on port 80; HTTPS can be added as needed.

### Time Spent ####

   Planning & Architecture: 20mins
   Terraform Coding (main.tf, variables.tf, outputs.tf, provider.tf): 1 hours
   Testing & Debugging: 20mins
   README & Documentation: 20mins
   Total: ~ 2 hours



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


# DIRECTORY STRUCTURE

iac-project/
├── main.tf                  # All AWS resources: VPC, subnets, security groups, ALB, ASG, EC2, RDS, S3
├── variables.tf             # All variables for environment, instance types, DB credentials, etc.
├── outputs.tf               # Outputs for VPC ID, subnets, ALB DNS, RDS endpoint, S3 bucket, ASG name
├── provider.tf              # AWS provider configuration
├── README.md                # Instructions to deploy and architecture explanation
└── scripts/
    └── user_data.sh         # Optional: EC2 user_data script for bootstrapping servers

Notes

main.tf: Contains all resources in one file.

variables.tf: Centralizes all input variables for flexibility.

outputs.tf: Centralizes outputs that you can reference after deployment.

provider.tf: Configures AWS provider region.

scripts/user_data.sh: Optional file for EC2 initialization