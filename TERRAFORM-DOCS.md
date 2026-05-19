<!-- BEGIN_TF_DOCS -->


## Requirements

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |

## Providers

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.35.1 |

## Resources

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ec2_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.cloudwatch_logs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3_app_data_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.alb_logs_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cross_account_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ec2_instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.rds_monitoring_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ec2_cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ec2_s3_app_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda_basic_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda_vpc_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.rds_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., prod, dev, test) | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_create_alb_logs_role"></a> [create\_alb\_logs\_role](#input\_create\_alb\_logs\_role) | Create IAM role for ALB access logs | `bool` | `false` | no |
| <a name="input_create_cross_account_role"></a> [create\_cross\_account\_role](#input\_create\_cross\_account\_role) | Create cross-account access role | `bool` | `false` | no |
| <a name="input_create_ec2_role"></a> [create\_ec2\_role](#input\_create\_ec2\_role) | Create IAM role for EC2 instances | `bool` | `true` | no |
| <a name="input_create_lambda_role"></a> [create\_lambda\_role](#input\_create\_lambda\_role) | Create IAM role for Lambda functions | `bool` | `false` | no |
| <a name="input_create_rds_monitoring_role"></a> [create\_rds\_monitoring\_role](#input\_create\_rds\_monitoring\_role) | Create IAM role for RDS enhanced monitoring | `bool` | `false` | no |
| <a name="input_create_s3_app_policy"></a> [create\_s3\_app\_policy](#input\_create\_s3\_app\_policy) | Create S3 policy for application data access | `bool` | `false` | no |
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | External ID for cross-account role assumption (mandatory for PSA compliance) | `string` | `""` | no |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | IAM path to apply to created roles, policies, and instance profiles | `string` | `"/"` | no |
| <a name="input_lambda_vpc_access"></a> [lambda\_vpc\_access](#input\_lambda\_vpc\_access) | Grant Lambda VPC access permissions | `bool` | `false` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names (if not provided, will use project-environment pattern) | `string` | `""` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the roles | `string` | `null` | no |
| <a name="input_s3_app_prefix"></a> [s3\_app\_prefix](#input\_s3\_app\_prefix) | S3 prefix for application data | `string` | `"app-data"` | no |
| <a name="input_s3_bucket_arn"></a> [s3\_bucket\_arn](#input\_s3\_bucket\_arn) | ARN of the S3 bucket for application data | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags for all resources | `map(string)` | `{}` | no |
| <a name="input_trusted_account_arns"></a> [trusted\_account\_arns](#input\_trusted\_account\_arns) | List of trusted AWS account ARNs for cross-account access | `list(string)` | `[]` | no |

## Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_logs_role_arn"></a> [alb\_logs\_role\_arn](#output\_alb\_logs\_role\_arn) | The ARN of the ALB logs role |
| <a name="output_cloudwatch_logs_policy_arn"></a> [cloudwatch\_logs\_policy\_arn](#output\_cloudwatch\_logs\_policy\_arn) | The ARN of the scoped CloudWatch Logs policy |
| <a name="output_cross_account_role_arn"></a> [cross\_account\_role\_arn](#output\_cross\_account\_role\_arn) | The ARN of the cross-account role |
| <a name="output_ec2_instance_profile_arn"></a> [ec2\_instance\_profile\_arn](#output\_ec2\_instance\_profile\_arn) | The ARN of the EC2 instance profile |
| <a name="output_ec2_instance_profile_name"></a> [ec2\_instance\_profile\_name](#output\_ec2\_instance\_profile\_name) | The name of the EC2 instance profile |
| <a name="output_ec2_instance_role_arn"></a> [ec2\_instance\_role\_arn](#output\_ec2\_instance\_role\_arn) | The ARN of the EC2 instance role |
| <a name="output_ec2_instance_role_name"></a> [ec2\_instance\_role\_name](#output\_ec2\_instance\_role\_name) | The name of the EC2 instance role |
| <a name="output_lambda_basic_execution_policy_arn"></a> [lambda\_basic\_execution\_policy\_arn](#output\_lambda\_basic\_execution\_policy\_arn) | The ARN of the AWS managed Lambda basic execution policy |
| <a name="output_lambda_execution_role_arn"></a> [lambda\_execution\_role\_arn](#output\_lambda\_execution\_role\_arn) | The ARN of the Lambda execution role |
| <a name="output_lambda_vpc_execution_policy_arn"></a> [lambda\_vpc\_execution\_policy\_arn](#output\_lambda\_vpc\_execution\_policy\_arn) | The ARN of the AWS managed Lambda VPC execution policy |
| <a name="output_rds_monitoring_policy_arn"></a> [rds\_monitoring\_policy\_arn](#output\_rds\_monitoring\_policy\_arn) | The ARN of the AWS managed RDS monitoring policy |
| <a name="output_rds_monitoring_role_arn"></a> [rds\_monitoring\_role\_arn](#output\_rds\_monitoring\_role\_arn) | The ARN of the RDS monitoring role |
| <a name="output_s3_app_data_policy_arn"></a> [s3\_app\_data\_policy\_arn](#output\_s3\_app\_data\_policy\_arn) | The ARN of the scoped S3 application data policy |
<!-- END_TF_DOCS -->