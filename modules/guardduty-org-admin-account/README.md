# terraform-aws-tardigrade-guardduty/org_admin_account

Terraform module for managing a GuardDuty org_admin_account.
Creates a GuardDuty org administrator account in an AWS organization.  Once created, all AWS accounts added to the AWS organization will be enrolled in GuardDuty and managed by the delegated GuardDuty org administrator account
  - Creates a GuardDuty detector for the org's GuardDuty administrator account
  - Creates a GuardDuty organization administrator account
  - Configures the delegated GuardDuty administrator organization configuration

Prerequisites:  The AWS org must already exist

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_aws.guardduty_administrator"></a> [aws.guardduty\_administrator](#provider\_aws.guardduty\_administrator) | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_guardduty_administrator_account"></a> [guardduty\_administrator\_account](#input\_guardduty\_administrator\_account) | (Required) AWS account identifier to designate as a delegated administrator for GuardDuty. | `string` | n/a | yes |
| <a name="input_enable"></a> [enable](#input\_enable) | (Optional) Enable monitoring and feedback reporting. Setting to false is equivalent to 'suspending'GuardDuty. Defaults to true. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_org_admin_account"></a> [org\_admin\_account](#output\_org\_admin\_account) | GuardDuty Organization Admin Account |

<!-- END TFDOCS -->
