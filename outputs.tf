output "detector" {
  description = "GuardDuty filter"
  value       = aws_guardduty_detector.this
}
output "filter" {
  description = "GuardDuty filter"
  value       = var.filter != null ? aws_guardduty_filter.this : null
}

output "ipset" {
  description = "GuardDuty ipset"
  value       = var.ipset != null ? aws_guardduty_ipset.this : null
}

output "threatintelset" {
  description = "GuardDuty threatintelset"
  value       = var.threatintelset != null ? aws_guardduty_threatintelset.this : null
}

output "publishing_destination" {
  description = "GuardDuty publishing destination"
  value       = var.publishing_destination != null ? aws_guardduty_publishing_destination.this : null
}




