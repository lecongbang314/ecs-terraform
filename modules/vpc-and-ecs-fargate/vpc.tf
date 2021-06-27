resource "aws_vpc" "vpc_ap1" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true

  tags = merge(
    var.tf_tags,
    {
      Name = "vpc-ap1"
  }, )
}

resource "aws_internet_gateway" "igw" {
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

data "aws_route_tables" "rts" {
  vpc_id = aws_vpc.vpc_ap1.id
}

resource "aws_route_table_association" "associate_rtb_subnet" {
  subnet_id      = aws_subnet.subnet_ap1_public.id
  route_table_id = tolist(data.aws_route_tables.rts.ids)[0]
}

resource "aws_route" "route_to_igw" {
  route_table_id         = tolist(data.aws_route_tables.rts.ids)[0]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_internet_gateway.igw]
}
