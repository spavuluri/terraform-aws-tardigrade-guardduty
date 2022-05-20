# terraform-aws-tardigrade-guardduty/org_admin_account

Terraform module for managing a GuardDuty member_account.

## Testing

You can find example implementations of this module in the tests folder (create_guardduty_member). This module requires 2 different AWS accounts to test. 

Note: the implementation `tests/create_guardduty_member` will require you to provide the a GuardDuty member object (see variables.tf) prior to use

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_aws.administrator"></a> [aws.administrator](#provider\_aws.administrator) | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.administrator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_guardduty_detector.administrator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/guardduty_detector) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_member"></a> [member](#input\_member) | GuardDuty member | <pre>object({<br>    email                      = string # (Required) Email address for member account.<br>    invitation_message         = string # (Optional) Message for invitation.<br>    disable_email_notification = bool   # (Optional) Boolean whether an email notification is sent to the accounts. Defaults to false.<br>  })</pre> | n/a | yes |
| <a name="input_enable"></a> [enable](#input\_enable) | (Optional) Enable monitoring and feedback reporting. Setting to false is equivalent to 'suspending' GuardDuty. Defaults to true. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_detector"></a> [detector](#output\_detector) | GuardDuty member account detector |
| <a name="output_invite_accepter"></a> [invite\_accepter](#output\_invite\_accepter) | GuardDuty aws\_guardduty\_invite\_accepter |
| <a name="output_member"></a> [member](#output\_member) | GuardDuty member configuration |

<!-- END TFDOCS -->
