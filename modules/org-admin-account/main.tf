# Creates a GuardDuty org administrator account in an AWS organization.  Once created, all AWS accounts added to the AWS organization will be enrolled in GuardDuty and managed by the delegated GuardDuty org administrator account
# - Creates a GuardDuty organization administrator account
# - Configures the delegated GuardDuty administrator organization configuration
#
# Prerequisites:
# - The AWS org must already exist
# - The AWS account to be delegated as the organization's GuardDuty administrator must already have GuardDuty enabled (i.e, have a detector)

# Create the organization's GuardDuty administrator account
resource "aws_guardduty_organization_admin_account" "this" {
  # Setting this to your organization's mamagement account is not recommended following the principle of least provilege.  It is recommended that another account be created to manage your organization's GuardDuty accounts.
  admin_account_id = var.delegated_administrator_account_id
}

# Configure the delegated GuardDuty administrator organization configuration
resource "aws_guardduty_organization_configuration" "this" {
  auto_enable = true
  detector_id = var.delegated_administrator_account_detecter_id

  datasources {
    s3_logs {
      auto_enable = true
    }
  }
}
