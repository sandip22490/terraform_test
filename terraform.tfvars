terragrunt = {
  terraform {
    extra_arguments "aws_access" {
      commands = [
        "import",
        "refresh",
        "plan",
      ]

      arguments = [
        "-var-file=${path_relative_to_include()}/aws_access.tfvars",
        "-input=false",
      ]
    }
  }

  remote_state {
    backend = "s3"

    config {
      bucket         = "${get_env("TF_VAR_project_name", "")}-terraform-state-${get_env("TF_VAR_stage", "")}"
      key            = "terraform_${get_env("TF_VAR_stage", "")}.tfstate"
      region         = "us-east-1"
      encrypt        = true
      dynamodb_table = "${get_env("TF_VAR_project_name", "")}-terraform-state-${get_env("TF_VAR_stage", "")}"
    }
  }
}
