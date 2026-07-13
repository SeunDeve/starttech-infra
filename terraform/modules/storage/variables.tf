variable "environment" {
  type = string
}

variable "bucket_name" {
  description = "Globally-unique S3 bucket name for the React frontend static assets"
  type        = string
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository for the Go backend container images"
  type        = string
  default     = "starttech-backend"
}

variable "tags" {
  type    = map(string)
  default = {}
}
