# The provider account for the GuardDuty member account
provider "aws" {
  region  = "us-east-1"
  profile = "plus3it-member" # Profile must exist in your .aws/config
}

# AWS provider account for the GuardDuty primary account
provider "aws" {
  region  = "us-east-1"
  alias   = "administrator"
  profile = "plus3it-management" # Profile must exist in your .aws/config
}

# Create GuardDuty detector for the administrator account
resource "aws_guardduty_detector" "administrator" {
  provider = aws.administrator
  enable   = true
}

# Invite this member account to join the administrator account GuardDuty organization.
# - Creates a GuardDuty detector for the member account
# - Creates a GuardDuty member resource in the administrator account which imnvites the member account to join the administrator account GuardDuty organization.
# - Creates a GuardDuty invite accepter in the member account to accept the invite from the administrator account
module "guardduty_member" {
  source = "../../modules/guardduty-member-account"

  enable = true

  providers = {
    aws               = aws
    aws.administrator = aws.administrator
  }

  member = {
    email                      = "aws-accounts+tardigrade-dev-tenant-001@plus3it.com"
    invite                     = true
    invitation_message         = "You are invited to join GuardDuty"
    disable_email_notification = true
  }

  depends_on = [aws_guardduty_detector.administrator]
}
