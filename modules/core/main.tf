data "aws_caller_identity" "current" {}

output "export" {
  value = {
    account_id  = data.aws_caller_identity.current.account_id
    lb_dns_name = aws_lb.this.dns_name
  }
}
