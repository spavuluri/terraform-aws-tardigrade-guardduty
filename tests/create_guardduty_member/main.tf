provider aws {
  region  = "us-east-1"
  profile = "resource-member"
}

provider aws {
  region  = "us-east-1"
  alias   = "resource-owner"
  profile = "resource-owner"
}

module "create_guardduty_member" {
  source = "../../"

  providers = {
    aws        = "aws"
    aws.master = "aws.resource-owner"
  }

  guardduty_master_detector_id = "<insert_detector_id>"
  email_address                = "<insert_email>"
}
