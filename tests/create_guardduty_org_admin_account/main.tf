module "guardduty_org_admin_account" {
  source = "../../modules/guardduty-org-admin-account"

  enable = true

  /*providers = {
    aws        = aws
    aws.member = aws.resource-owner
  }*/

  guardduty_administrator_account = "123455668"
}
