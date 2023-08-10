module "core" {
  source = "../../modules/core"
  config = local.this
}

output "export" {
  value = module.core.export
}

output "config" {
  value = local.this
}

locals {
  this = yamldecode(file("config.yaml"))["this"]
}

# Pin version to avoid breaking in future changes
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }
  }
  required_version = "~> 1.5.0"
}
