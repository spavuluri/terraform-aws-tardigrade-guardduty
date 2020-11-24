provider aws {
  region  = "us-east-1"
  profile = "resource-member"
}

provider aws {
  region  = "us-east-1"
  alias   = "resource-owner"
  profile = "resource-owner"
}

module guardduty_member {
  source = "../../"

  providers = {
    aws        = aws
    aws.master = aws.resource-owner
  }

  guardduty_master_detector_id = aws_guardduty_detector.master.id
  email_address                = var.member_email

  depends_on = [
    aws_guardduty_detector.master
  ]
}

resource aws_guardduty_detector master {
  provider = aws.resource-owner

  enable = true
}

variable member_email {
  description = "Email address associated with the member account. Required input for the Guardduty member invitation."
  type        = string
}
