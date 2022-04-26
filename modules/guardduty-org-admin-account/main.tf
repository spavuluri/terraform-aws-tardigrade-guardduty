# The current AWS provider account is the organization's mamagement account
provider "aws" {
  region = "us-east-1"
  //profile = "resource-owner"  # Create after successful testing
}

# Create AWS Organization using the current AWS account as the organization's mamagement account
resource "aws_organizations_organization" "this" {
  aws_service_access_principals = ["guardduty.amazonaws.com"]
  feature_set                   = "ALL"
}

# Create GuardDuty detector for the primary (admin) account
/*resource "aws_guardduty_detector" "primary" {
  enable = var.enable
} */

# AWS provider account for the delegated GuardDuty administrator account
provider "aws" {
  region = "us-east-1"
  alias  = "guardduty_administrator"
  //profile = "resource-member"  # Create after successful testing
}

# Delegate the organization's GuardDuty administrator account
resource "aws_guardduty_organization_admin_account" "this" {
  # Setting this to your organization's mamagement account is not recommended following the principle of least provilege.  It is recommended that another account ibe created to manage your organization's GuardDuty accounts.
  admin_account_id = aws_guardduty_detector.guardduty_administrator.account_id
  //admin_account_id = var.guardduty_administrator_account

  depends_on = [aws_organizations_organization.this]
}

# Create GuardDuty detector for the organization's GuardDuty administrator account
resource "aws_guardduty_detector" "guardduty_administrator" {
  provider = aws.guardduty_administrator
  enable   = var.enable
}

# Configure the delegated GuardDuty administrator
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



