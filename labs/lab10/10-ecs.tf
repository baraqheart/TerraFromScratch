resource "aws_ecs_cluster" "cluster1" {
  name = var.cluster_name

}

resource "aws_ecs_service" "service1" {
  name            = var.service1
  cluster         = aws_ecs_cluster.cluster1.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 2
  iam_role        = aws_iam_role.ecs.arn
  depends_on      = [aws_iam_role_policy.ecs]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend.arn
    container_name   = "container"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [${local.region}a, ${local.region}b]"
  }
}