######################################################## ALB Security group ########################################################

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.vpc_ap1.id

  ingress {
    description = "Access to http ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.tf_tags,
    {
      Name = "Allow HTTP to ALB"
  }, )
}

######################################################## ECS Security group ########################################################

resource "aws_security_group" "ecs_sg" {
  name        = "ecs_sg"
  description = "ECS Security Group"
  vpc_id      = aws_vpc.vpc_ap1.id

  ingress {
    description = "Access to http ECS from ALB"
    from_port   = 1
    to_port     = 65534
    protocol    = "tcp"
    # cidr_blocks = [aws_vpc.vpc_ap1.cidr_block]
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    description = "Access to http ECS"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.tf_tags,
    {
      Name = "Allow HTTP to ECS"
  }, )
}

