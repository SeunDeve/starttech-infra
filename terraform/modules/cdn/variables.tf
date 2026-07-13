variable "environment" {
  type = string
}

variable "s3_bucket_id" {
  type = string
}

variable "s3_bucket_regional_domain_name" {
  type = string
}

variable "s3_bucket_arn" {
  type = string
}

variable "alb_dns_name" {
  description = <<-EOT
    DNS name of the ALB fronting the EKS-hosted Go API (created dynamically by
    the AWS Load Balancer Controller from a Kubernetes Ingress resource - a
    chicken-and-egg dependency on the cluster). Leave as the placeholder on
    first apply, then re-apply with the real ALB DNS name once the Ingress
    is live (see scripts/deploy-infrastructure.sh phase 2).
  EOT
  type        = string
  default     = "placeholder.alb.not-yet-provisioned.example.com"
}

variable "price_class" {
  type    = string
  default = "PriceClass_100"
}

variable "tags" {
  type    = map(string)
  default = {}
}
