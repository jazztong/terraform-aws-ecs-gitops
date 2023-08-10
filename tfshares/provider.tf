# The following block will be reuse in many environment
provider "aws" {
  region = "ap-southeast-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.aws_provision_id}:role/${var.aws_provision_role}"
  }
  default_tags {
    tags = try(local.this.tags)
  }
}

variable "aws_provision_id" {
  type        = string
  description = "aws account id to be use to provision"
}

variable "aws_provision_role" {
  type        = string
  description = "aws role name to be use to provision"
}
