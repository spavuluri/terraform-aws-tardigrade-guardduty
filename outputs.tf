output "detector" {
  description = "GuardDuty filter"
  value       = aws_guardduty_detector.this
}
output "filter" {
  description = "GuardDuty filter"
  value       = aws_guardduty_filter.this
}

output "ipset" {
  description = "GuardDuty filter"
  value       = aws_guardduty_ipset.this
}

output "threatintelset" {
  description = "GuardDuty filter"
  value       = aws_guardduty_threatintelset.this
}

output "ublishing_destination" {
  description = "GuardDuty filter"
  value       = aws_guardduty_publishing_destination.this
}




