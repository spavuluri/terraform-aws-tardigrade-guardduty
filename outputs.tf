output "detector" {
  description = "GuardDuty detector"
  value       = aws_guardduty_detector.this
}
output "filter" {
  description = "GuardDuty filter"
  value       = aws_guardduty_filter.this
}

output "ipset" {
  description = "GuardDuty ipset"
  value       = aws_guardduty_ipset.this
}

output "threatintelset" {
  description = "GuardDuty threatintelset"
  value       = aws_guardduty_threatintelset.this
}

output "publishing_destination" {
  description = "GuardDuty publishing destination"
  value       = aws_guardduty_publishing_destination.this
}
