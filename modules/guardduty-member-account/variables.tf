variable "enable" {
  description = "(Optional) Enable monitoring and feedback reporting. Setting to false is equivalent to 'suspending'GuardDuty. Defaults to true."
  type        = bool
  default     = true
}

variable "member" {
  description = "GuardDuty member"
  type = object({
    email                      = string # (Required) Email address for member account.
    invite                     = string # ((Optional) Boolean whether to invite the account to GuardDuty as a member. Defaults to false.
    invitation_message         = string # (Optional) Message for invitation.
    disable_email_notification = bool   # (Optional) Boolean whether an email notification is sent to the accounts. Defaults to false.
  })
  default = null
}
