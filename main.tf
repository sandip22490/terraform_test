#specific version

# Initializing provider

provider "aws" {
  version    = "~> 1.11"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# Retriving current user account_id for further use

data "aws_caller_identity" "current" {}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend          "s3"             {}
  required_version = "0.11.7"
}

resource "aws_dynamodb_table" "temp-table" {
  name           = "${var.project_name}-temp-table"
  hash_key       = "tempId"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "tempId"
    type = "S"
  }
}

resource "aws_dynamodb_table" "temp-table-another" {
  name           = "${var.project_name}-temp-table-another"
  hash_key       = "tempId"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "tempId"
    type = "S"
  }
}
