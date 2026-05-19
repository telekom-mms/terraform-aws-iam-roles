// examples/basic-roles/outputs.tf

output "ec2_instance_role_arn" {
  description = "ARN of the EC2 instance role"
  value       = module.iam_roles.ec2_instance_role_arn
}

output "rds_monitoring_role_arn" {
  description = "ARN of the RDS monitoring role"
  value       = module.iam_roles.rds_monitoring_role_arn
}

output "lambda_execution_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = module.iam_roles.lambda_execution_role_arn
}

output "alb_logs_role_arn" {
  description = "ARN of the ALB logs role"
  value       = module.iam_roles.alb_logs_role_arn
}

output "cross_account_role_arn" {
  description = "ARN of the cross-account role"
  value       = module.iam_roles.cross_account_role_arn
}

output "s3_app_data_policy_arn" {
  description = "ARN of the S3 application data policy"
  value       = module.iam_roles.s3_app_data_policy_arn
}
