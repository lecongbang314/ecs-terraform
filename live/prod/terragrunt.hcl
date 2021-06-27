# Define the module to use
terraform {
  source = "../../modules/vpc-and-ecs-fargate"
}

# Inherit backend config from root 
include {
  path = find_in_parent_folders()
}

# Input for module
inputs = {
  # VPC vars
  vpc_cidr            = "11.0.0.0/16"
  subnet_cidr_public  = "11.0.1.0/24"
  subnet_cidr_private = "11.0.10.0/24"
  # ECS vars
  service_name   = "fruit-shop"
  environment    = "PROD"
  image_registry = "214259409527.dkr.ecr.ap-southeast-1.amazonaws.com/fruit-shop:0.0.1"
  task_replicas  = 2
  task_cpu       = 512
  task_memory    = 1024
}