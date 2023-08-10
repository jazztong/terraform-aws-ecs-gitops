locals {
  stack_name = try(var.config.stack_name, "default-stack")
  tags       = var.config.tags
}
