variable "enable" {
  description = "(Optional) Enable monitoring and feedback reporting. Setting to false is equivalent to 'suspending' GuardDuty. Defaults to true."
  type        = bool
  default     = true
}

variable "enable_s3_protection" {
  description = "(Required) If true, enables S3 Protection. Defaults to true."
  type        = bool
  default     = true
}

variable "enable_kubernetes_protection" {
  description = "(Required) If true, enables S3 Protection. Defaults to true."
  type        = bool
  default     = true
}

variable "enable_malware_protection" {
  description = "(Required) If true, enables S3 Protection. Defaults to true."
  type        = bool
  default     = true
}

variable "finding_publishing_frequency" {
  description = "(Optional) Specifies the frequency of notifications sent for subsequent finding occurrences. If the detector is a GuardDuty member account, the value is determined by the GuardDuty primary account and cannot be modified, otherwise defaults to SIX_HOURS. For standalone and GuardDuty primary accounts, it must be configured in Terraform to enable drift detection. Valid values for standalone and primary accounts: FIFTEEN_MINUTES, ONE_HOUR, SIX_HOURS."
  type        = string
  default     = "SIX_HOURS"
  validation {
    condition     = var.finding_publishing_frequency != null ? contains(["FIFTEEN_MINUTES", "ONE_HOUR", "SIX_HOURS"], var.finding_publishing_frequency) : true
    error_message = "The aws_guardduty_detector finding_publishing_frequency value is not valid. Valid values: FIFTEEN_MINUTES, ONE_HOUR, or SIX_HOURS."
  }
}

variable "member" {
  description = "GuardDuty member"
  type = object({
    email                      = string # (Required) Email address for member account.
    invitation_message         = string # (Optional) Message for invitation.
    disable_email_notification = bool   # (Optional) Boolean whether an email notification is sent to the accounts. Defaults to false.
  })
}
