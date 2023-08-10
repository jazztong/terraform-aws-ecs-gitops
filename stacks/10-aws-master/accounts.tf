resource "aws_organizations_account" "prod" {
  name = "PROD Lab"
  #You need to have unique email for each AWS Account, uncomment email block and provide your email
  #email     = "<<replace your prod account email>>"

  #We will create consistent Org Access Role for easy management
  role_name = "OrganizationAccountAccessRole"

  lifecycle {
    ignore_changes = [role_name]
  }
}

resource "aws_organizations_account" "preprod" {
  name = "Preprod"
  #You need to have unique email for each AWS Account, uncomment email block and provide your email
  #email     = "<<replace your prod account email>>"

  #We will create consistent Org Access Role for easy management
  role_name = "OrganizationAccountAccessRole"

  lifecycle {
    ignore_changes = [role_name]
  }
}

output "prod_account_number" {
  value = ""
}
