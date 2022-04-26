# This file allows stabdard GuardDuty configuration to be created.  These include a detector, filter, ipset, threatintelset,a nd publshing destination.  The GuardDuty configurations not included in this modulae require multiple AWS accounts.  Therefore, the terraform code for these configurations has been implemented in seperate submodeles (see the modules section of this project).

resource "aws_guardduty_detector" "this" {
  enable = var.enable
}

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

resource "aws_guardduty_ipset" "this" {
  count = var.ipset == null ? 0 : 1

  detector_id = aws_guardduty_detector.this.id
  activate    = var.ipset.activate
  format      = var.ipset.format
  location    = var.ipset.location
  name        = var.ipset.name
  tags        = var.ipset.tags
}

resource "aws_guardduty_threatintelset" "this" {
  count = var.threatintelset == null ? 0 : 1

  detector_id = aws_guardduty_detector.this.id
  activate    = var.threatintelset.activate
  format      = var.threatintelset.format
  location    = var.threatintelset.location
  name        = var.threatintelset.name
  tags        = var.threatintelset.tags
}

# This resource assumes the S3 bucket associated with the destination arn exists and the required policies have been created to allow GuardDuty to access the bucket.  It also assumes the kms key associated with the kms key arn exists and has a policy that allows GuardDuty to to use it.
resource "aws_guardduty_publishing_destination" "this" {
  count = var.publishing_destination == null ? 0 : 1

  detector_id      = aws_guardduty_detector.this.id
  destination_arn  = var.publishing_destination.destination_arn
  kms_key_arn      = var.publishing_destination.kms_key_arn
  destination_type = "S3" # S3 is currently the only option for this
}
