variable "enable" {
  description = "(Optional) Enable monitoring and feedback reporting. Setting to false is equivalent to 'suspending'GuardDuty. Defaults to true."
  type        = bool
  default     = true
}

variable "delegated_administrator_account_id" {
  description = "(Required) AWS account identifier to designate as a delegated administrator for GuardDuty."
  type        = string
}

variable "delegated_administrator_account_detecter_id" {
  description = "(Required) GuardDuty detector ID of the AWS account identifier to designate as a delegated administrator for GuardDuty."
  type        = string
}
