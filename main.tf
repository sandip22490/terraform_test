# Initializing provider

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# Retriving current user account_id for further use

data "aws_caller_identity" "current" {}

# create S3 bucket to store the terraform remote state

resource "aws_s3_bucket" "terraform_remote_state" {
  bucket = "${var.project_name}-terraform-remote-state"

  versioning {
    enabled = true
  }
}

# Create dynamodb table for locking the remote state file

resource "aws_dynamodb_table" "terraform_remote_state" {
  name           = "${var.project_name}-terraform-remote-state"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Create terraform remote state backend
# When initializing stage for the first time, disable this and then enable it for remote state.

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "maxxsure-terraform-remote-state"
    dynamodb_table = "maxxsure-terraform-remote-state"
    region         = "us-east-1"
    key            = "terraform.tfstat"
    profile        = "maxxsure-dev"
  }
}
