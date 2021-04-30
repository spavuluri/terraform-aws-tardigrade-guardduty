provider "aws" {
  alias = "master"
}

resource "aws_guardduty_detector" "this" {
  enable = true
}

resource "aws_guardduty_member" "this" {
  provider = aws.master

  account_id                 = aws_guardduty_detector.this.account_id
  detector_id                = var.guardduty_master_detector_id
  email                      = var.email_address
  invite                     = true
  invitation_message         = "You are invited to enable Amazon Guardduty."
  disable_email_notification = true

  lifecycle {
    ignore_changes = [invite]
  }
}

resource "aws_guardduty_invite_accepter" "this" {
  detector_id       = aws_guardduty_detector.this.id
  master_account_id = data.aws_caller_identity.master.account_id

  depends_on = [aws_guardduty_member.this]
}

data "aws_caller_identity" "master" {
  provider = aws.master
}
