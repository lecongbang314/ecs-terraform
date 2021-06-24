# variable "aws_region" {
#   description = "AWS region to run in"
#   type        = string
# }

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
  type        = string
}

variable "subnet_cidr_public" {
  description = "subnet_cidr"
  default     = "10.0.1.0/24"
  type        = string
}

variable "subnet_cidr_private" {
  description = "subnet_cidr"
  default     = "10.0.10.0/24"
  type        = string
}


variable "tf_tags" {
  default = {
    ManagedBy = "Terraform"
  }
  description = "Tagging resources which are managed by Terraform"
  type        = map(string)
}