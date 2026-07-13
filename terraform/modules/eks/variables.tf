variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS control plane (1.34+)"
  type        = string
  default     = "1.34"
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  description = "Private subnets for worker nodes (and the control plane ENIs)"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public subnets, needed if the control plane endpoint should reach public ALB/NLBs"
  type        = list(string)
  default     = []
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

variable "node_disk_size" {
  type    = number
  default = 20
}

variable "tags" {
  type    = map(string)
  default = {}
}
