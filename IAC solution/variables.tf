variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "env" {
  description = "Environment name"
  default     = "dev"
}

variable "app_instance_type" {
  description = "EC2 instance type for app servers"
  default     = "t3.medium"
}

variable "key_pair_name" {
  description = "SSH key pair for EC2 instances"
  type        = string
}

variable "db_name" {
  description = "RDS database name"
  type        = string
}

variable "db_username" {
  description = "RDS database username"
  type        = string
}

variable "db_password" {
  description = "RDS database password"
  type        = string
  sensitive   = true
}

variable "asg_min_size" {
  description = "Minimum size of Auto Scaling Group"
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum size of Auto Scaling Group"
  default     = 4
}

variable "asg_desired_capacity" {
  description = "Desired capacity of Auto Scaling Group"
  default     = 2
}
