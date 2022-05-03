# AWS provider account for the GuardDuty org administrator account
provider "aws" {
  region  = "us-east-1"
  profile = "plus3it-member" # Profile must exist in your .aws/config
}

# AWS provider account for the AWS organization
provider "aws" {
  region  = "us-east-1"
  alias   = "administrator"
  profile = "plus3it-management" # Profile must exist in your .aws/config
}

# Create AWS Organization in the admninistrator provider account
resource "aws_organizations_organization" "this" {
  provider                      = aws.administrator
  aws_service_access_principals = ["guardduty.amazonaws.com"]
  feature_set                   = "ALL"
}

# Create a GuardDuty org administrator account in the AWS organization
# - Creates a GuardDuty detector for the org's GuardDuty administrator account
# - Creates a GuardDuty organization administrator account
# - Configures the delegated GuardDuty administrator organization configuration
#
# Prerequisites:  The AWS org must already exist
module "guardduty_org_admin_account" {
  source = "../../modules/guardduty-org-admin-account"

  enable = true

  providers = {
    aws               = aws
    aws.administrator = aws.administrator
  }

  guardduty_administrator_account = "123455668"

  depends_on = [aws_organizations_organization.this]
}
