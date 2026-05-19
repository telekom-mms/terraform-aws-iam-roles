// main.tf
# Written by Marc Straubinger - Overhauled for Security-First Best Practices

# Current AWS Account and Region
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# EC2 Instance Role for Web/App Tier
# PSA Compliance: Req 1 (least privilege access)
resource "aws_iam_role" "ec2_instance_role" {
  count                = var.create_ec2_role ? 1 : 0
  name                 = "${local.name_prefix}-ec2-instance-role"
  path                 = var.iam_path
  permissions_boundary = var.permissions_boundary

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-ec2-instance-role"
    "Purpose"       = "EC2 Instance Role"
    "PSA-Compliant" = "true"
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  count = var.create_ec2_role ? 1 : 0
  name  = "${local.name_prefix}-ec2-instance-profile"
  path  = var.iam_path
  role  = aws_iam_role.ec2_instance_role[0].name

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-ec2-instance-profile"
    "Purpose"       = "EC2 Instance Profile"
    "PSA-Compliant" = "true"
  })
}

# CloudWatch Logs Policy for EC2 (PSA Req 3.66-05: Logging obligatory)
# PSA Compliance: Req 1 (least privilege access)
resource "aws_iam_policy" "cloudwatch_logs_policy" {
  count = var.create_ec2_role ? 1 : 0
  name  = "${local.name_prefix}-cloudwatch-logs-policy"
  path  = var.iam_path

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        # PSA Compliance: Restricted to specific log groups
        Resource = "arn:aws:logs:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:log-group:/aws/ec2/${local.name_prefix}-*:*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:DescribeLogGroups"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-cloudwatch-logs-policy"
    "Purpose"       = "Scoped CloudWatch logging"
    "PSA-Compliant" = "true"
  })
}

resource "aws_iam_role_policy_attachment" "ec2_cloudwatch_logs" {
  count      = var.create_ec2_role ? 1 : 0
  role       = aws_iam_role.ec2_instance_role[0].name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy[0].arn
}

# RDS Role for enhanced monitoring
# PSA Compliance: Req 1 (least privilege access)
resource "aws_iam_role" "rds_monitoring_role" {
  count                = var.create_rds_monitoring_role ? 1 : 0
  name                 = "${local.name_prefix}-rds-monitoring-role"
  path                 = var.iam_path
  permissions_boundary = var.permissions_boundary

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-rds-monitoring-role"
    "Purpose"       = "RDS Enhanced Monitoring"
    "PSA-Compliant" = "true"
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  count      = var.create_rds_monitoring_role ? 1 : 0
  role       = aws_iam_role.rds_monitoring_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# Lambda Execution Role
# PSA Compliance: Req 1 (least privilege access)
resource "aws_iam_role" "lambda_execution_role" {
  count                = var.create_lambda_role ? 1 : 0
  name                 = "${local.name_prefix}-lambda-execution-role"
  path                 = var.iam_path
  permissions_boundary = var.permissions_boundary

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-lambda-execution-role"
    "Purpose"       = "Lambda Execution"
    "PSA-Compliant" = "true"
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  count      = var.create_lambda_role ? 1 : 0
  role       = aws_iam_role.lambda_execution_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_vpc_execution" {
  count      = var.create_lambda_role && var.lambda_vpc_access ? 1 : 0
  role       = aws_iam_role.lambda_execution_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# Application Load Balancer Logs Role (S3 Log Delivery)
# PSA Compliance: Req 1 (least privilege access)
resource "aws_iam_role" "alb_logs_role" {
  count                = var.create_alb_logs_role ? 1 : 0
  name                 = "${local.name_prefix}-alb-logs-role"
  path                 = var.iam_path
  permissions_boundary = var.permissions_boundary

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-alb-logs-role"
    "Purpose"       = "ALB Access Logs Delivery"
    "PSA-Compliant" = "true"
  })
}

# S3 Bucket Policy for Application Data (PSA Compliance: Least Privilege)
# PSA Compliance: Req 1 (least privilege access)
resource "aws_iam_policy" "s3_app_data_policy" {
  count = var.create_s3_app_policy ? 1 : 0
  name  = "${local.name_prefix}-s3-app-data-policy"
  path  = var.iam_path

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowAppAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/${var.s3_app_prefix}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "true" # PSA Compliance: Enforce SSL
          }
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-s3-app-data-policy"
    "Purpose"       = "Scoped application data access"
    "PSA-Compliant" = "true"
  })
}

resource "aws_iam_role_policy_attachment" "ec2_s3_app_data" {
  count      = var.create_ec2_role && var.create_s3_app_policy ? 1 : 0
  role       = aws_iam_role.ec2_instance_role[0].name
  policy_arn = aws_iam_policy.s3_app_data_policy[0].arn
}

# Cross-Account Role (PSA Req 3.69: MFA and RBAC mandatory)
# PSA Compliance: Req 1 (least privilege access)
resource "aws_iam_role" "cross_account_role" {
  count                = var.create_cross_account_role ? 1 : 0
  name                 = "${local.name_prefix}-cross-account-role"
  path                 = var.iam_path
  permissions_boundary = var.permissions_boundary

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = var.trusted_account_arns
        }
        Condition = {
          StringEquals = {
            "sts:ExternalId" = var.external_id # PSA Compliance: Prevent confused deputy
          }
          Bool = {
            "aws:MultiFactorAuthPresent" = "true" # PSA Compliance: Require MFA
          }
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    "Name"          = "${local.name_prefix}-cross-account-role"
    "Purpose"       = "Cross-Account Access"
    "PSA-Compliant" = "true"
  })
}
