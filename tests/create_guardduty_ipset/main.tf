# Creates a GuardDuty ipset for this account.
# - Creates a GuardDuty detector for this account
# - Creates a GuardDuty ipset for this account
module "guardduty_ipset" {
  source = "../../"

  enable = true

  ipsets = [
    {
      name     = "Ipset1"
      activate = true
      format   = "TXT"
      location = "https://s3.amazonaws.com/${aws_s3_object.ipSet1.bucket}/${aws_s3_object.ipSet1.key}"
      tags = {
        environment = "testing"
      }
    } /*,  Can only set one ipset in without a limit increase
    {
      name     = "Ipset2"
      activate = true
      format   = "TXT"
      location = "https://s3.amazonaws.com/${aws_s3_object.ipSet2.bucket}/${aws_s3_object.ipSet2.key}"
      tags = {
        environment = "testing"
      }
    }*/
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

resource "aws_s3_object" "ipSet1" {
  acl     = "private"
  content = "10.10.0.0/8\n"
  bucket  = aws_s3_bucket.bucket.id
  key     = "IpSet1"
}

resource "aws_s3_object" "ipSet2" {
  acl     = "private"
  content = "10.20.0.0/8\n"
  bucket  = aws_s3_bucket.bucket.id
  key     = "IpSet2"
}
