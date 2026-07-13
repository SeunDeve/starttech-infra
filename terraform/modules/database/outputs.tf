output "redis_endpoint" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}

output "redis_port" {
  value = aws_elasticache_cluster.redis.port
}

output "redis_security_group_id" {
  value = aws_security_group.redis.id
}

output "redis_cluster_id" {
  value = aws_elasticache_cluster.redis.cluster_id
}
