######################################################## ECS cluster ########################################################

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.service_name}-Cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

######################################################## ECS Task Definition ########################################################


data "template_file" "ecs_task_definition" {
  template = file("${path.module}/container_definition.json")

  vars = {
    container_name = var.service_name
    image_registry = var.image_registry
  }
}

resource "aws_ecs_task_definition" "task" {

  container_definitions = data.template_file.ecs_task_definition.rendered

  family                   = "${var.service_name}-task"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  execution_role_arn = aws_iam_role.fargate_iam_role.arn
  task_role_arn      = aws_iam_role.fargate_iam_role.arn
}

######################################################## ECS Service ########################################################

resource "aws_ecs_service" "service" {

  name            = "${var.service_name}-service"
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.task_replicas
  cluster         = aws_ecs_cluster.ecs_cluster.id
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.subnet_ap1_public.id]
    security_groups  = [aws_security_group.alb_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    container_name   = var.service_name
    container_port   = 80
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
  }
  depends_on = [aws_lb_listener.ecs_http_listener]
}
