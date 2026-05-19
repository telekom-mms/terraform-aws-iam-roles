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
  description = "Prefix for resource names (if not provided, will use project-environment pattern)"
  type        = string
  default     = ""
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

variable "iam_path" {
  description = "IAM path to apply to created roles, policies, and instance profiles"
  type        = string
  default     = "/"

  validation {
    condition     = can(regex("^/([^/]+/)*$", var.iam_path))
    error_message = "iam_path must be '/' or use slash-delimited path segments like '/team/service/'."
  }
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

  validation {
    condition     = var.create_s3_app_policy ? var.s3_bucket_arn != "" : true
    error_message = "s3_bucket_arn must be provided when create_s3_app_policy is true."
  }
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

  validation {
    condition     = var.create_cross_account_role ? length(var.trusted_account_arns) > 0 : true
    error_message = "trusted_account_arns must contain at least one ARN when create_cross_account_role is true."
  }
}

variable "external_id" {
  description = "External ID for cross-account role assumption (mandatory for PSA compliance)"
  type        = string
  default     = ""

  validation {
    condition     = var.create_cross_account_role ? var.external_id != "" : true
    error_message = "external_id must be provided when create_cross_account_role is true."
  }
}
