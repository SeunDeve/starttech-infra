############################################
# ElastiCache Subnet Group - private database subnets
############################################
resource "aws_elasticache_subnet_group" "redis" {
  name       = "starttech-redis-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.environment}-starttech-redis-subnet-group"
  })
}

############################################
# Security Group - only allow inbound traffic from EKS worker nodes
############################################
resource "aws_security_group" "redis" {
  name        = "starttech-redis-sg"
  description = "Allow Redis (6379) traffic only from EKS worker nodes"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.environment}-starttech-redis-sg"
  })
}

resource "aws_security_group_rule" "redis_ingress_from_eks" {
  type                     = "ingress"
  security_group_id        = aws_security_group.redis.id
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = var.eks_node_security_group_id
  description               = "Allow Redis access from EKS worker nodes only"
}

resource "aws_security_group_rule" "redis_egress_all" {
  type              = "egress"
  security_group_id = aws_security_group.redis.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

############################################
# ElastiCache Redis - single-node cluster
############################################
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "starttech-redis"
  engine               = "redis"
  engine_version       = var.engine_version
  node_type            = var.node_type
  num_cache_nodes      = 1
  port                 = 6379
  parameter_group_name = "default.redis7"

  subnet_group_name = aws_elasticache_subnet_group.redis.name
  security_group_ids = [aws_security_group.redis.id]

  apply_immediately = true

  tags = merge(var.tags, {
    Name = "starttech-redis"
  })
}
