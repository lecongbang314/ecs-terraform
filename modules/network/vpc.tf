resource "aws_vpc" "vpc_ap1" {
  cidr_block = var.vpc_cidr

  tags = merge(
    var.tf_tags,
    {
      Name = "vpc-ap1"
  }, )
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_ap1.id

  tags = merge(
    var.tf_tags,
    {
      Name = "IGW"
  }, )
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "subnet_ap1_public" {

  vpc_id            = aws_vpc.vpc_ap1.id
  cidr_block        = var.subnet_cidr_public
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = merge(
    var.tf_tags,
    {
      Name = "subnet-ap1-public"
  }, )
}

resource "aws_subnet" "subnet_ap1_private" {

  vpc_id            = aws_vpc.vpc_ap1.id
  cidr_block        = var.subnet_cidr_private
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = merge(
    var.tf_tags,
    {
      Name = "subnet-ap1-private"
  }, )
}