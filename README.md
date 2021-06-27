# ECS Terraform Demo

## Description
This project stimulates an ECS infrastructure created by Terraform/Terragrunt and has Terratest for unit testing
## Getting started
### Prerequisite
Have AWS credentials configuration. Some recommended ways:
- [aws-vault](https://github.com/99designs/aws-vault) session
- Export to environment variables
- Use as Terraform variables
### Backend provisioning
Provision S3 and DynamoDB as backend
```
cd provision-s3-dynamodb-backend
terraform init
terraform plan --out "tfplan"
terraform apply "tfplan"

```
Clean up
```
terraform destroy
```
### Environment provisioning
Provision ECS to both uat and prod
```
cd live
terragrunt run-all apply
```
Clean up
```
terragrunt run-all destroy
```
### Module development
Update code in [modules/vpc-and-ecs-fargate](./modules/vpc-and-ecs-fargate)

Run Terratest
```
cd modules/testing
go test -v ecs_test.go
```

## License
Distributed under the MIT License. See [LICENSE](./LICENSE) for more information.


