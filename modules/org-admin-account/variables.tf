variable "enable" {
  description = "(Optional) Enable monitoring and feedback reporting. Setting to false is equivalent to 'suspending'GuardDuty. Defaults to true."
  type        = bool
  default     = true
}

variable "delegated_administrator_account" {
  description = "(Required) AWS account identifier to designate as a delegated administrator for GuardDuty."
  type        = string
}
