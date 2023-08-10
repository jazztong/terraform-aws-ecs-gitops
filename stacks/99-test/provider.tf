// Use default
provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = try(local.this.tags)
  }
}
