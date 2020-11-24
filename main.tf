# -----------------------------------------------------------
# PROVIDERS
# "aws" is a GuardDuty Member account
# "aws.master" is the GuardDuty Master account
# -----------------------------------------------------------

provider "aws" {
  alias = "master"
}

data "aws_caller_identity" "master" {
  provider = aws.master
}

# -----------------------------------------------------------
# GuardDuty Member Creation
# Role: Member Account
# Purpose: Enables GuardDuty by provisioning a "detector" for the member account
# -----------------------------------------------------------
resource "aws_guardduty_detector" "member" {
  provider = aws

  enable = true
}

# -----------------------------------------------------------
# GuardDuty Member Invite
# Role: Master Account
# Purpose: Sends a GuardDuty Member invitation to the member account
# -----------------------------------------------------------

resource "aws_guardduty_member" "invite" {
  provider = aws.master

  account_id                 = aws_guardduty_detector.member.account_id
  detector_id                = var.guardduty_master_detector_id
  email                      = var.email_address
  invite                     = true
  invitation_message         = "You are invited to enable Amazon Guardduty."
  disable_email_notification = true

  lifecycle {
    ignore_changes = [invite]
  }
}

# -----------------------------------------------------------
# GuardDuty Member Invite Acceptance
# Role: Member Account
# Purpose: Accepts the invitation from the GuardDuty Master
# -----------------------------------------------------------
resource "aws_guardduty_invite_accepter" "this" {
  detector_id       = aws_guardduty_detector.member.id
  master_account_id = data.aws_caller_identity.master.account_id

  depends_on = [aws_guardduty_member.invite]
}
