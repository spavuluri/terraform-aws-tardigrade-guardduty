# Creates a GuardDuty threatintelset for this account.
# - Creates a GuardDuty detector for this account
# - Creates a GuardDuty threatintelset for this account
module "guardduty_threatintelset" {
  source = "../../"

  enable = true

  threatintelset = [
    {
      name     = "ThreatIntelSet1"
      activate = true
      format   = "TXT"
      location = "https://s3.amazonaws.com/${aws_s3_object.ThreatIntelSet1.bucket}/${aws_s3_object.ThreatIntelSet1.key}"
      tags = {
        environment = "testing"
      }
    },
    {
      name     = "ThreatIntelSet2"
      activate = true
      format   = "TXT"
      location = "https://s3.amazonaws.com/${aws_s3_object.ThreatIntelSet2.bucket}/${aws_s3_object.ThreatIntelSet2.key}"
      tags = {
        environment = "testing"
      }
    }
  ]
}

resource "random_id" "name" {
  byte_length = 6
  prefix      = "tardigrade-s3-bucket-"
}

resource "aws_s3_bucket" "bucket" {
  bucket        = random_id.name.hex
  force_destroy = true
  tags = {
    environment = "testing"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "ThreatIntelSet1" {
  acl     = "public-read"
  content = "10.0.0.0/8\n"
  bucket  = aws_s3_bucket.bucket.id
  key     = "ThreatIntelSet1"
}

resource "aws_s3_object" "ThreatIntelSet2" {
  acl     = "public-read"
  content = "10.0.0.0/8\n"
  bucket  = aws_s3_bucket.bucket.id
  key     = "ThreatIntelSet2"
}
