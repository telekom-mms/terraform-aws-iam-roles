# AWS IAM Roles Basic Example

This example demonstrates how to use the AWS IAM Roles module to create various IAM roles and policies.

## Features

- EC2 Instance Role
- RDS Monitoring Role
- Lambda Execution Role (with VPC access)
- ALB Logs Role
- S3 Application Data Policy
- Cross-Account Role

## Usage

1.  Copy this example to your project.
2.  Update `variables.tf` with your specific values.
3.  **Important**: Before applying, ensure you replace `arn:aws:s3:::your-s3-bucket-name`, `arn:aws:iam::123456789012:root`, and `your-external-id` in `main.tf` with actual values.
4.  Initialize and apply:
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```

## Variables

See `variables.tf` for all configurable options.

## Outputs

- ARNs of the created IAM roles and policies.

## Requirements

- AWS CLI configured
- Terraform >= 1.0
