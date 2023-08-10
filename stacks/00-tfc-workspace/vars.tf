variable "organization" {
  type        = string
  description = "Organization for Terraform Cloud"
}

// To be set in runtime
variable "github_install_id" {
  type        = string
  description = "Github Installation ID"
}
