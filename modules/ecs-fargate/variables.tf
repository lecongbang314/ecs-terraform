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

variable "service_name" {
  description = "Name of ECS service"
  type        = string
}

variable "image_registry" {
  description = "Registry of image"
  type        = string
}

variable "task_replicas" {
  description = "Numbers of task run in a service"
  type        = number
  default     = 1
}

variable "task_cpu" {
  description = "CPU required for task"
  type        = number
  default     = 512
}

variable "task_memory" {
  description = "Memory required for task"
  type        = number
  default     = 1024
}