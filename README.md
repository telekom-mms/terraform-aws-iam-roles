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
