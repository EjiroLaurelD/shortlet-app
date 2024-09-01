output "uptime_check_id" {
  description = "The ID of the uptime check"
  value       = google_monitoring_uptime_check_config.api_uptime.name
}

output "alert_policy_id" {
  description = "The ID of the alert policy"
  value       = google_monitoring_alert_policy.api_alert_policy.name
}

