module "guardduty_member" {
  source = "../../modules/guardduty-member-account"

  enable = true

  /*providers = {
    aws        = aws
    aws.member = aws.plus3it-member
  }*/

  member = {
    email                      = "kevin.cahn@plus3it.com"
    invite                     = true
    invitation_message         = "You are invited to join dicelab GuardDuty"
    disable_email_notification = true
  }
}
