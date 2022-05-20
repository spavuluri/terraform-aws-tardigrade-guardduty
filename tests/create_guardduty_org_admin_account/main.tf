# AWS provider account for the AWS organization
provider "aws" {
  region  = "us-east-1"
  profile = "aws" # Profile must exist in your .aws/config
}

# AWS provider account for the GuardDuty org administrator account
provider "aws" {
  region  = "us-east-1"
  alias   = "guardduty_administrator"
  profile = "awsalternate" # Profile must exist in your .aws/config
}

# Create AWS Organization in the this account
resource "aws_organizations_organization" "this" {
  aws_service_access_principals = ["guardduty.amazonaws.com"]
  feature_set                   = "ALL"
}

# Create GuardDuty detector for the organization's delegated GuardDuty administrator account
resource "aws_guardduty_detector" "guardduty_administrator" {
  provider = aws.guardduty_administrator
  enable   = true
}

# Get the current caller identity of the organization's delegated GuardDuty administrator account to use to get its account ID
data "aws_caller_identity" "administrator" {
  provider = aws.guardduty_administrator
}

# Create a GuardDuty org administrator account in the AWS organization
# - Creates a GuardDuty organization administrator account
# - Configures the delegated GuardDuty administrator organization configuration
#
# Prerequisites:  The AWS org must already exist
module "guardduty_org_admin_account" {
  source = "../../modules/org-admin-account"

  enable                                      = true
  delegated_administrator_account_id          = data.aws_caller_identity.administrator.account_id
  delegated_administrator_account_detecter_id = aws_guardduty_detector.guardduty_administrator.id

  depends_on = [aws_organizations_organization.this]
}
