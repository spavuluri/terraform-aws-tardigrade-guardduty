# terraform-aws-tardigrade-guardduty

Terraform module to create a GuardDuty Detector in a child account and link it
to a pre-existing detector in the parent account

## Testing

You can find example implementations of this module in the tests folder. This module
requires 2 different AWS accounts to test and so the terraform aws provider definitions
are assuming that you will be using a profile with the name `resource-owner` and `resource-member`.

Note: the implementation `tests/create_guardduty_member` will require you to provide the variables
`guardduty_master_detector_id` and `email_address` prior to use


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
| <a name="provider_aws.master"></a> [aws.master](#provider\_aws.master) | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email_address"></a> [email\_address](#input\_email\_address) | Email address associated with the member account. Required input for the GuardDuty member invitation. | `string` | n/a | yes |
| <a name="input_guardduty_master_detector_id"></a> [guardduty\_master\_detector\_id](#input\_guardduty\_master\_detector\_id) | GuardDuty Detector ID for master account | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END TFDOCS -->
