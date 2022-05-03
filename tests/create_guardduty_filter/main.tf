# Creates a GuardDuty filter for this account.
# - Creates a GuardDuty detector for this account
# - Creates a GuardDuty filter for this account
module "guardduty_filter" {
  source = "../../"

  enable = true

  filter = {
    name        = "MyFilter"
    description = "My Filter"
    rank        = 1
    action      = "ARCHIVE"
    tags = {
      environment = "testing"
    }
    criterion = [
      {
        field                 = "severity"
        equals                = ["4"]
        not_equals            = ["1"]
        greater_than          = null
        greater_than_or_equal = null
        less_than             = null
        less_than_or_equal    = null
      }
    ]
  }
}
