# We will use all subnet from default vpc
data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}

# We will use default VPC for now, if this is failing, ensure you have one default VPC
data "aws_vpc" "this" {
  default = true
}
