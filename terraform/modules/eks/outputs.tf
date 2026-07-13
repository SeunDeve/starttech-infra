output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_ca_data" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_arn" {
  value = aws_eks_cluster.this.arn
}

# Security group automatically created and managed by EKS for the
# cluster/control-plane <-> worker node communication. Used by the
# database module to scope ElastiCache ingress to EKS workers only.
output "node_security_group_id" {
  value = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}

output "oidc_provider_url" {
  value = aws_iam_openid_connect_provider.eks.url
}

output "node_role_arn" {
  value = aws_iam_role.node.arn
}

output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}
