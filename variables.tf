// variables.tf

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., prod, dev, test)"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names (e.g., 'myapp-prod')"
  type        = string
}

variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}

variable "permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the roles"
  type        = string
  default     = null
}

# EC2 Instance Role Configuration
variable "create_ec2_role" {
  description = "Create IAM role for EC2 instances"
  type        = bool
  default     = true
}

# RDS Monitoring Role Configuration
variable "create_rds_monitoring_role" {
  description = "Create IAM role for RDS enhanced monitoring"
  type        = bool
  default     = false
}

# Lambda Execution Role Configuration
variable "create_lambda_role" {
  description = "Create IAM role for Lambda functions"
  type        = bool
  default     = false
}

variable "lambda_vpc_access" {
  description = "Grant Lambda VPC access permissions"
  type        = bool
  default     = false
}

# ALB Logs Role Configuration
variable "create_alb_logs_role" {
  description = "Create IAM role for ALB access logs"
  type        = bool
  default     = false
}

# S3 Application Data Policy Configuration
variable "create_s3_app_policy" {
  description = "Create S3 policy for application data access"
  type        = bool
  default     = false
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket for application data"
  type        = string
  default     = ""
}

variable "s3_app_prefix" {
  description = "S3 prefix for application data"
  type        = string
  default     = "app-data"
}

# Cross-Account Role Configuration
variable "create_cross_account_role" {
  description = "Create cross-account access role"
  type        = bool
  default     = false
}

variable "trusted_account_arns" {
  description = "List of trusted AWS account ARNs for cross-account access"
  type        = list(string)
  default     = []
}

variable "external_id" {
  description = "External ID for cross-account role assumption (Mandatory for PSA compliance)"
  type        = string
  default     = ""
}
