# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket    = "waficash-helloworkflow"
    key       = "hello-workflow.tfstate"
    region    = "us-east-1"
    profile   = "terraform-user"
  }
}