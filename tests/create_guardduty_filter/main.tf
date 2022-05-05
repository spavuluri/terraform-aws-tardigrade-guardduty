# Creates a GuardDuty filter for this account.
# - Creates a GuardDuty detector for this account
# - Creates two GuardDuty filters for this account
module "guardduty_filter" {
  source = "../../"

  enable = true

  filter = [
    {
      name        = "Filter1"
      description = "My Filter 1"
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
    },
    {
      name        = "Filter2"
      description = "My Filter 2"
      rank        = 1
      action      = "ARCHIVE"
      tags = {
        environment = "testing"
      }
      criterion = [
        {
          field                 = "accountId"
          equals                = ["123418158163", "123458158163"]
          not_equals            = ["223418158163", "223458158163"]
          greater_than          = null
          greater_than_or_equal = null
          less_than             = null
          less_than_or_equal    = null
          }, {
          field                 = "region"
          equals                = ["us-east-1"]
          not_equals            = null
          greater_than          = null
          greater_than_or_equal = null
          less_than             = null
          less_than_or_equal    = null
        }
      ]
    }
  ]
}
