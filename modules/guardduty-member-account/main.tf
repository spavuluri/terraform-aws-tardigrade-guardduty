# The current AWS provider account is the GuardDuty primary account
provider "aws" {
  region  = "us-east-1"
  profile = "plus3it-management" # Profile must exist in your .aws/config
}

# AWS provider account for the GuardDuty member account
provider "aws" {
  region  = "us-east-1"
  alias   = "member"
  profile = "plus3it-member" # Profile must exist in your .aws/config
}

# Create GuardDuty detector for the primary account
resource "aws_guardduty_detector" "primary" {
  enable = var.enable
}

# Create GuardDuty detector for the member account
resource "aws_guardduty_detector" "member" {
  provider = aws.member
  enable   = var.enable
}

# Create GuardDuty member in the primary account
resource "aws_guardduty_member" "this" {
  count = var.member == null ? 0 : 1

  account_id                 = aws_guardduty_detector.member.account_id
  detector_id                = aws_guardduty_detector.primary.id
  email                      = var.member.email
  invite                     = var.member.invite
  invitation_message         = var.member.invitation_message
  disable_email_notification = var.member.disable_email_notification
}

# Create GuardDuty invite accepter in the member account
resource "aws_guardduty_invite_accepter" "this" {
  count = var.member == null ? 0 : 1

  provider = aws.member

  detector_id       = aws_guardduty_detector.member.id
  master_account_id = data.aws_caller_identity.primary.account_id

  depends_on = [aws_guardduty_member.this]
}

# Get the current caller identity to use to get the primary account ID
data "aws_caller_identity" "primary" {}
