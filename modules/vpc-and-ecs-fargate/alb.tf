######################################################## ALB ########################################################

resource "aws_lb" "ecs_alb" {
  name               = "ALB-ECS-${var.service_name}-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_sg.id]
  subnets            = [aws_subnet.subnet_ap1_public.id, aws_subnet.subnet_ap1_private.id]

  enable_deletion_protection = false
  depends_on                 = [aws_internet_gateway.igw]
  tags = merge(
    var.tf_tags,
    {
      Name = "ALB-ECS"
  }, )
}

######################################################## Target group ########################################################

resource "aws_lb_target_group" "ecs_target_group" {
  name        = "ECS-TG-${var.service_name}-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc_ap1.id
  target_type = "ip"

  tags = merge(
    var.tf_tags,
    {
      Name = "ECS-TG"
  }, )

  health_check {
    enabled             = true
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 15
    interval            = 30
  }
}

######################################################## Listener ########################################################

resource "aws_lb_listener" "ecs_http_listener" {
  load_balancer_arn = aws_lb.ecs_alb.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
  }

  depends_on = [aws_lb_target_group.ecs_target_group]
}

