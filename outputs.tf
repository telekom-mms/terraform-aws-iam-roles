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

output "rds_monitoring_role_arn" {
  description = "The ARN of the RDS monitoring role"
  value       = try(aws_iam_role.rds_monitoring_role[0].arn, null)
}

output "lambda_execution_role_arn" {
  description = "The ARN of the Lambda execution role"
  value       = try(aws_iam_role.lambda_execution_role[0].arn, null)
}

output "cross_account_role_arn" {
  description = "The ARN of the cross-account role"
  value       = try(aws_iam_role.cross_account_role[0].arn, null)
}
