variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-3"
}

variable "environment" {
  description = "Environment name (e.g. production, staging)"
  type        = string
  default     = "production"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "starttech-eks"
}

variable "cluster_version" {
  description = "Kubernetes version (1.34+)"
  type        = string
  default     = "1.34"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["eu-west-3a", "eu-west-3b"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "node_min_size" {
  type    = number
  default = 2
}

variable "node_max_size" {
  type    = number
  default = 4
}

variable "frontend_bucket_name" {
  description = "Globally-unique S3 bucket name for the React frontend"
  type        = string
}

variable "ecr_repository_name" {
  type    = string
  default = "starttech-backend"
}

variable "alb_dns_name" {
  description = "DNS name of the ALB created by the AWS Load Balancer Controller for the /api ingress. Populate after the k8s Ingress is applied, then re-run terraform apply."
  type        = string
  default     = "placeholder.alb.not-yet-provisioned.example.com"
}

variable "redis_node_type" {
  type    = string
  default = "cache.t3.micro"
}

variable "redis_engine_version" {
  type    = string
  default = "7.1"
}

variable "tags" {
  type = map(string)
  default = {
    Project   = "StartTech"
    ManagedBy = "Terraform"
  }
}
