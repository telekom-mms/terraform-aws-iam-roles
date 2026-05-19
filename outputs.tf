// outputs.tf

output "ec2_instance_role_arn" {
  description = "The ARN of the EC2 instance role"
  value       = try(aws_iam_role.ec2_instance_role[0].arn, null)
}

output "ec2_instance_role_name" {
  description = "The name of the EC2 instance role"
  value       = try(aws_iam_role.ec2_instance_role[0].name, null)
}

output "ec2_instance_profile_arn" {
  description = "The ARN of the EC2 instance profile"
  value       = try(aws_iam_instance_profile.ec2_instance_profile[0].arn, null)
}

output "ec2_instance_profile_name" {
  description = "The name of the EC2 instance profile"
  value       = try(aws_iam_instance_profile.ec2_instance_profile[0].name, null)
}

output "rds_monitoring_role_arn" {
  description = "The ARN of the RDS monitoring role"
  value       = try(aws_iam_role.rds_monitoring_role[0].arn, null)
}

output "lambda_execution_role_arn" {
  description = "The ARN of the Lambda execution role"
  value       = try(aws_iam_role.lambda_execution_role[0].arn, null)
}

output "alb_logs_role_arn" {
  description = "The ARN of the ALB logs role"
  value       = try(aws_iam_role.alb_logs_role[0].arn, null)
}

output "cross_account_role_arn" {
  description = "The ARN of the cross-account role"
  value       = try(aws_iam_role.cross_account_role[0].arn, null)
}

output "cloudwatch_logs_policy_arn" {
  description = "The ARN of the scoped CloudWatch Logs policy"
  value       = try(aws_iam_policy.cloudwatch_logs_policy[0].arn, null)
}

output "rds_monitoring_policy_arn" {
  description = "The ARN of the AWS managed RDS monitoring policy"
  value       = var.create_rds_monitoring_role ? "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole" : null
}

output "lambda_basic_execution_policy_arn" {
  description = "The ARN of the AWS managed Lambda basic execution policy"
  value       = var.create_lambda_role ? "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" : null
}

output "lambda_vpc_execution_policy_arn" {
  description = "The ARN of the AWS managed Lambda VPC execution policy"
  value       = var.create_lambda_role && var.lambda_vpc_access ? "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole" : null
}

output "s3_app_data_policy_arn" {
  description = "The ARN of the scoped S3 application data policy"
  value       = try(aws_iam_policy.s3_app_data_policy[0].arn, null)
}
