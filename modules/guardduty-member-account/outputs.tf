output "guardduty_member" {
  description = "GuardDuty Organization Admin Account"
  value       = aws_guardduty_member.this
}
