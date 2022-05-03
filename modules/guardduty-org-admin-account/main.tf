# Creates a GuardDuty org administrator account in an AWS organization
# - Creates a GuardDuty detector for the org's GuardDuty administrator account
# - Creates a GuardDuty organization administrator account
# - Configures the delegated GuardDuty administrator organization configuration
#
# Prerequisites:  The AWS org must already exist

# Create GuardDuty detector for the organization's GuardDuty administrator account
resource "aws_guardduty_detector" "guardduty_administrator" {
  provider = aws.guardduty_administrator
  enable   = var.enable
}

# Create the organization's GuardDuty administrator account
resource "aws_guardduty_organization_admin_account" "this" {
  # Setting this to your organization's mamagement account is not recommended following the principle of least provilege.  It is recommended that another account be created to manage your organization's GuardDuty accounts.
  admin_account_id = aws_guardduty_detector.guardduty_administrator.account_id
}

# Configure the delegated GuardDuty administrator organization configuration
resource "aws_guardduty_organization_configuration" "this" {
  auto_enable = true
  detector_id = aws_guardduty_detector.guardduty_administrator.id

  datasources {
    s3_logs {
      auto_enable = true
    }
  }
}

# Get the current caller identity to use to get the primary account ID
data "aws_caller_identity" "primary" {}



