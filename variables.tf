variable email_address {
  description = "Email address associated with the member account. Required input for the GuardDuty member invitation."
  type        = string
}

variable guardduty_master_detector_id {
  description = "GuardDuty Detector ID for master account"
  type        = string
}
