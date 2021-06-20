resource "aws_vpc" "vpc_ap1" {
  cidr_block = var.vpc_cidr

  tags = merge(
    var.tf_tags,
    {
      Name = "vpc-ap1"
  }, )
}

resource "aws_subnet" "subnet_ap1_public" {

  vpc_id     = aws_vpc.vpc_ap1.id
  cidr_block = var.subnet_cidr_public

  tags = merge(
    var.tf_tags,
    {
      Name = "subnet-ap1-public"
  }, )
}

resource "aws_subnet" "subnet_ap1_private" {

  vpc_id     = aws_vpc.vpc_ap1.id
  cidr_block = var.subnet_cidr_private

  tags = merge(
    var.tf_tags,
    {
      Name = "subnet-ap1-private"
  }, )
}