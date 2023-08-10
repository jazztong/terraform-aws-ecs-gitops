resource "aws_ecs_cluster" "this" {
  name = "ecs-cluster-${local.stack_name}-${local.tags.env}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
