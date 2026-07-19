############################################
# Networking
############################################
output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns_name
}

############################################
# EKS
############################################
output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_node_security_group_id" {
  value = module.eks.node_security_group_id
}

output "eks_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

############################################
# Storage
############################################
output "frontend_bucket_id" {
  value = module.storage.bucket_id
}

output "ecr_repository_url" {
  value = module.storage.ecr_repository_url
}

############################################
# CDN
############################################
output "cloudfront_distribution_id" {
  value = module.cdn.distribution_id
}

output "cloudfront_domain_name" {
  value = module.cdn.distribution_domain_name
}

############################################
# Database
############################################
output "redis_endpoint" {
  value = module.database.redis_endpoint
}

output "redis_port" {
  value = module.database.redis_port
}
