variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  description = "Private (database) subnets for the ElastiCache subnet group"
  type        = list(string)
}

variable "eks_node_security_group_id" {
  description = "Security group ID of the EKS worker nodes - only this SG may reach Redis"
  type        = string
}

variable "node_type" {
  type    = string
  default = "cache.t3.micro"
}

variable "engine_version" {
  type    = string
  default = "7.1"
}

variable "tags" {
  type    = map(string)
  default = {}
}
