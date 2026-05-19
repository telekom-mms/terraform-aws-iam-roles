<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Unlicense License][license-shield]][license-url]

<br />

<!-- PROJECT LOGO -->
<div align="center">
  <a href="https://github.com/telekom-mms/terraform-aws-iam-roles">
    <img src="logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">AWS IAM Roles Module</h3>

  <p align="center">
    PSA-compliant IAM roles module with mandatory permissions boundaries, MFA requirements, and least-privilege templates.
    <br />
    <a href="https://github.com/telekom-mms/terraform-aws-iam-roles"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/telekom-mms/terraform-aws-iam-roles">View Demo</a>
    ·
    <a href="https://github.com/telekom-mms/terraform-aws-iam-roles/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/telekom-mms/terraform-aws-iam-roles/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

## Documentation

Full auto-generated documentation of inputs, outputs, and resources: [TERRAFORM-DOCS.md](TERRAFORM-DOCS.md)

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#security-features">Security Features</a></li>
    <li><a href="#psa-compliance-features">PSA Compliance Features</a></li>
    <li><a href="#outputs">Outputs</a></li>
    <li><a href="#troubleshooting">Troubleshooting</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This module centralizes the creation of commonly used IAM roles (EC2, Lambda, RDS Monitoring, Cross-Account) following the principle of least privilege. It integrates security guardrails like permissions boundaries and MFA-enforced cross-account access.

### Features

- **Standardized Roles**: Pre-defined templates for EC2, Lambda, and RDS.
- **Permissions Boundaries**: Mandatory support for global guardrails.
- **Cross-Account Security**: MFA and External ID enforcement for trust relationships.
- **Scoped Policies**: S3 and CloudWatch policies are restricted to specific resources by default.
- **Tag-Based Access**: PSA-Compliant tags included for attribute-based access control (ABAC).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE -->
## Usage

### Basic Usage (EC2 Role with S3 Access)

```hcl
module "iam_roles" {
  source = "./terraform-aws-iam-roles"

  project_name = "myapp"
  environment  = "prod"
  name_prefix  = "myapp-prod"

  create_ec2_role      = true
  create_s3_app_policy = true
  s3_bucket_arn        = "arn:aws:s3:::myapp-data"
  s3_app_prefix        = "uploads"
}
```

### Advanced Usage (Cross-Account Role)

```hcl
module "cross_account" {
  source = "./terraform-aws-iam-roles"

  project_name = "audit"
  environment  = "prod"
  name_prefix  = "auditor"

  create_cross_account_role = true
  trusted_account_arns      = ["arn:aws:iam::123456789012:root"]
  external_id               = "Company-Audit-2024"

  permissions_boundary = "arn:aws:iam::account:policy/GlobalGuardrail"
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SECURITY FEATURES -->
## Security Features

- **No Wildcards**: CloudWatch and S3 policies avoid `*` resources wherever possible.
- **SSL Enforcement**: IAM policies for S3 access include a `Deny` statement for non-SSL requests.
- **Confused Deputy Protection**: Cross-account roles require an `ExternalId`.
- **MFA Enforcement**: Assumption of cross-account roles requires a valid MFA session.
- **Boundary Support**: Every role supports a `permissions_boundary` to ensure it cannot escalate privileges.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- PSA COMPLIANCE FEATURES -->
## PSA Compliance Features

This module implements the following PSA compliance features (referencing `01-Strukturierte_PSA_Anforderungen_Allgemein.pdf`):

### Security Controls

- **Req 3.69-01 (Identity Lifecycle)**: Standardized naming and tagging for all roles.
- **Req 3.69-03 (Separation of Roles)**: Distinct roles for execution (compute) and monitoring.
- **Req 3.01-06 (Strong Auth)**: MFA enforcement for sensitive cross-account operations.
- **Req 3.66-05 (Logging)**: CloudWatch logging policies are scoped to prevent broad log access.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- TROUBLESHOOTING -->
## Troubleshooting

### AccessDenied during Role Assumption

- Verify that the `external_id` matches exactly.
- Ensure the caller is using MFA if `create_cross_account_role` is used.
- Check that the Permissions Boundary is not overly restrictive.

### IAM Policy Size Limit

- If attaching many custom policies, consider consolidating them or using IAM Groups if applicable.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/telekom-mms/terraform-aws-iam-roles.svg?style=for-the-badge
[contributors-url]: https://github.com/telekom-mms/terraform-aws-iam-roles/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/telekom-mms/terraform-aws-iam-roles.svg?style=for-the-badge
[forks-url]: https://github.com/telekom-mms/terraform-aws-iam-roles/network/members
[stars-shield]: https://img.shields.io/github/stars/telekom-mms/terraform-aws-iam-roles.svg?style=for-the-badge
[stars-url]: https://github.com/telekom-mms/terraform-aws-iam-roles/stargazers
[issues-shield]: https://img.shields.io/github/issues/telekom-mms/terraform-aws-iam-roles.svg?style=for-the-badge
[issues-url]: https://github.com/telekom-mms/terraform-aws-iam-roles/issues
[license-shield]: https://img.shields.io/github/license/telekom-mms/terraform-aws-iam-roles.svg?style=for-the-badge
[license-url]: https://github.com/telekom-mms/terraform-aws-iam-roles/blob/master/LICENSE.txt

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

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
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_alb_logs_role"></a> [create\_alb\_logs\_role](#input\_create\_alb\_logs\_role) | Create IAM role for ALB access logs | `bool` | `false` | no |
| <a name="input_create_cross_account_role"></a> [create\_cross\_account\_role](#input\_create\_cross\_account\_role) | Create cross-account access role | `bool` | `false` | no |
| <a name="input_create_ec2_role"></a> [create\_ec2\_role](#input\_create\_ec2\_role) | Create IAM role for EC2 instances | `bool` | `true` | no |
| <a name="input_create_lambda_role"></a> [create\_lambda\_role](#input\_create\_lambda\_role) | Create IAM role for Lambda functions | `bool` | `false` | no |
| <a name="input_create_rds_monitoring_role"></a> [create\_rds\_monitoring\_role](#input\_create\_rds\_monitoring\_role) | Create IAM role for RDS enhanced monitoring | `bool` | `false` | no |
| <a name="input_create_s3_app_policy"></a> [create\_s3\_app\_policy](#input\_create\_s3\_app\_policy) | Create S3 policy for application data access | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., prod, dev, test) | `string` | n/a | yes |
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | External ID for cross-account role assumption (mandatory for PSA compliance) | `string` | `""` | no |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | IAM path to apply to created roles, policies, and instance profiles | `string` | `"/"` | no |
| <a name="input_lambda_vpc_access"></a> [lambda\_vpc\_access](#input\_lambda\_vpc\_access) | Grant Lambda VPC access permissions | `bool` | `false` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names (if not provided, will use project-environment pattern) | `string` | `""` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the roles | `string` | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_s3_app_prefix"></a> [s3\_app\_prefix](#input\_s3\_app\_prefix) | S3 prefix for application data | `string` | `"app-data"` | no |
| <a name="input_s3_bucket_arn"></a> [s3\_bucket\_arn](#input\_s3\_bucket\_arn) | ARN of the S3 bucket for application data | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags for all resources | `map(string)` | `{}` | no |
| <a name="input_trusted_account_arns"></a> [trusted\_account\_arns](#input\_trusted\_account\_arns) | List of trusted AWS account ARNs for cross-account access | `list(string)` | `[]` | no |

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