output "alb_dns" {
  value = aws_lb.ecs_alb.dns_name
}

output "task_definition" {
  value = aws_ecs_task_definition.task.arn
}
