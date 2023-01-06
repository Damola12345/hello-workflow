# Configured AWS Provider with Proper Credentials
# terraform aws provider
provider "aws" {
  region  = var.region
  profile = "terraform-user"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
