terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  # Remote state - configure to match your org's S3/DynamoDB backend.
  # backend "s3" {
  #   bucket         = "starttech-terraform-state"
  #   key            = "production/terraform.tfstate"
  #   region         = "eu-west-3"
  #   dynamodb_table = "starttech-terraform-locks"
  #   encrypt        = true
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.tags
  }
}

locals {
  common_tags = merge(var.tags, {
    Environment = var.environment
  })
}

############################################
# Networking
############################################
module "networking" {
  source = "./modules/networking"

  environment          = var.environment
  cluster_name         = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = local.common_tags
}



############################################
# ALB
############################################
module "alb" {
  source            = "./modules/alb"
  environment       = var.environment
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  tags              = local.common_tags
}


############################################
# EKS
############################################
module "eks" {
  source = "./modules/eks"

  environment         = var.environment
  cluster_name        = var.cluster_name
  cluster_version     = var.cluster_version
  vpc_id              = module.networking.vpc_id
  private_subnet_ids  = module.networking.private_subnet_ids
  public_subnet_ids   = module.networking.public_subnet_ids
  node_instance_types = var.node_instance_types
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  tags                = local.common_tags
}

############################################
# Storage (S3 frontend bucket + ECR repository)
############################################
module "storage" {
  source = "./modules/storage"

  environment         = var.environment
  bucket_name         = var.frontend_bucket_name
  ecr_repository_name = var.ecr_repository_name
  tags                = local.common_tags
}

############################################
# CDN (CloudFront - S3-Frontend + ALB-Backend origins)
############################################
module "cdn" {
  source = "./modules/cdn"

  environment                    = var.environment
  s3_bucket_id                   = module.storage.bucket_id
  s3_bucket_arn                  = module.storage.bucket_arn
  s3_bucket_regional_domain_name = module.storage.bucket_regional_domain_name
  alb_dns_name                   = var.alb_dns_name
  tags                           = local.common_tags
}

############################################
# Database (ElastiCache Redis)
############################################
module "database" {
  source = "./modules/database"

  environment                = var.environment
  vpc_id                     = module.networking.vpc_id
  private_subnet_ids         = module.networking.private_subnet_ids
  eks_node_security_group_id = module.eks.node_security_group_id
  node_type                  = var.redis_node_type
  engine_version             = var.redis_engine_version
  tags                       = local.common_tags
}
