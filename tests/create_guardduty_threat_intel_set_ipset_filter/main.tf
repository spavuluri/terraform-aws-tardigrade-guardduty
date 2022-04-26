module "guardduty_threatintelset_ipset_filter" {
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

  threatintelset = {
    name     = "MyThreatIntelSet"
    activate = true
    format   = "TXT"
    location = "https://s3.amazonaws.com/${aws_s3_object.MyThreatIntelSet.bucket}/${aws_s3_object.MyThreatIntelSet.key}"
    tags = {
      environment = "testing"
    }
  }

  ipset = {
    name     = "MyIpset"
    activate = true
    format   = "TXT"
    location = "https://s3.amazonaws.com/${aws_s3_object.ipSet.bucket}/${aws_s3_object.ipSet.key}"
    tags = {
      environment = "testing"
    }
  }
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

resource "aws_s3_object" "MyThreatIntelSet" {
  acl     = "public-read"
  content = "10.0.0.0/8\n"
  bucket  = aws_s3_bucket.bucket.id
  key     = "MyThreatIntelSet"
}

resource "aws_s3_object" "ipSet" {
  acl     = "public-read"
  content = "10.0.0.0/8\n"
  bucket  = aws_s3_bucket.bucket.id
  key     = "MyIpSet"
}
