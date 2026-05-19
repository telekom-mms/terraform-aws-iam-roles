// examples/basic-roles/main.tf

provider "aws" {
  region = "eu-central-1"
}

module "iam_roles" {
  source = "../../"

  name_prefix = var.name_prefix

  create_ec2_role            = true
  create_rds_monitoring_role = true
  create_lambda_role         = true
  lambda_vpc_access          = true
  create_alb_logs_role       = true
  create_s3_app_policy       = true
  s3_bucket_name             = "your-s3-bucket-name"
  s3_app_prefix              = "app-data"
  create_cross_account_role  = true
  trusted_account_arns       = ["arn:aws:iam::123456789012:root"]
  external_id                = "your-external-id"

  tags = var.tags
}
