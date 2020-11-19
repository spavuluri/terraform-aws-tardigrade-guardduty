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
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| aws.master | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| email\_address | Email address associated with the member account. Required input for the GuardDuty member invitation. | `string` | `null` | no |
| guardduty\_master\_detector\_id | GuardDuty Detector ID for master account | `string` | `null` | no |
| tags | A map of tags to add to the CFN resource for GuardDuty | `map(string)` | `{}` | no |

## Outputs

No output.

<!-- END TFDOCS -->
