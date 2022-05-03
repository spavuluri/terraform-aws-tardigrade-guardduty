# This file creates a standard GuardDuty configuration in a single AWS account.  These include a GuardDuty detector, filter, ipset, threatintelset, and publshing destination.  GuardDuty configurations that require multiple AWS accounts are not included in this module, and the terraform code for those configurations has been implemented in seperate submodeles (see the modules section of this project).
#
# - Creates a GuardDuty detector for this account
# - Creates a GuardDuty filter for this account if the filter var is not null.
# - Creates a GuardDuty ipset for this account if the ipset var is not null.
# - Creates a GuardDuty threatintelset for this account if the threatintelset var is not null.
# - Creates a GuardDuty publishing_destination for this account if the publishing_destination var is not null.
#
# Prerequisites:  This publishing_destination resource assumes the S3 bucket associated with the destination arn exists and the required policies have been created to
# allow GuardDuty to access the bucket.  It also assumes the kms key associated with the kms key arn exists and has a policy that allows GuardDuty to to use it.

# Creates a GuardDuty detector for this account
resource "aws_guardduty_detector" "this" {
  enable = var.enable
}

# Creates a GuardDuty filter for this account if the filter var is not null.
resource "aws_guardduty_filter" "this" {
  count = var.filter == null ? 0 : 1

  detector_id = aws_guardduty_detector.this.id
  name        = var.filter.name
  description = var.filter.description
  rank        = var.filter.rank
  action      = var.filter.action
  tags        = var.filter.tags
  finding_criteria {
    dynamic "criterion" {
      for_each = var.filter.criterion
      content {
        field                 = criterion.value.field
        equals                = criterion.value.equals
        not_equals            = criterion.value.not_equals
        greater_than          = criterion.value.greater_than
        greater_than_or_equal = criterion.value.greater_than_or_equal
        less_than             = criterion.value.less_than
        less_than_or_equal    = criterion.value.less_than_or_equal
      }
    }
  }
}

# Creates a GuardDuty ipset for this account if the ipset var is not null.
resource "aws_guardduty_ipset" "this" {
  count = var.ipset == null ? 0 : 1

  detector_id = aws_guardduty_detector.this.id
  activate    = var.ipset.activate
  format      = var.ipset.format
  location    = var.ipset.location
  name        = var.ipset.name
  tags        = var.ipset.tags
}

# Creates a GuardDuty threatintelset for this account if the threatintelset var is not null.
resource "aws_guardduty_threatintelset" "this" {
  count = var.threatintelset == null ? 0 : 1

  detector_id = aws_guardduty_detector.this.id
  activate    = var.threatintelset.activate
  format      = var.threatintelset.format
  location    = var.threatintelset.location
  name        = var.threatintelset.name
  tags        = var.threatintelset.tags
}

# Creates a GuardDuty publishing_destination for this account if the publishing_destination var is not null.
# This resource assumes the S3 bucket associated with the destination arn exists and the required policies have been created to allow GuardDuty to access the bucket.  It also assumes the kms key associated with the kms key arn exists and has a policy that allows GuardDuty to to use it.
resource "aws_guardduty_publishing_destination" "this" {
  count = var.publishing_destination == null ? 0 : 1

  detector_id      = aws_guardduty_detector.this.id
  destination_arn  = var.publishing_destination.destination_arn
  kms_key_arn      = var.publishing_destination.kms_key_arn
  destination_type = "S3" # S3 is currently the only option for this
}
