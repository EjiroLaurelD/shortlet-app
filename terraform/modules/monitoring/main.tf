resource "google_monitoring_uptime_check_config" "api_uptime" {
  display_name = "API Uptime Check"
  timeout      = "10s"
  period       = "60s"

  http_check {
    path = "/time"
    port = 80
    use_ssl = false
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      host = kubernetes_service.api_service.status[0].load_balancer[0].ingress[0].ip
    }
  }
}

resource "google_monitoring_alert_policy" "api_alert_policy" {
  display_name = "API Down Alert"

  conditions {
    display_name = "API Uptime Check Failed"
    condition_threshold {
      filter = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND resource.type=\"uptime_url\""
      comparison = "COMPARISON_LT"
      threshold_value = 1
      duration = "60s"

      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = "ALIGN_RATE"
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email_notification.name]
}

resource "google_monitoring_notification_channel" "email_notification" {
  display_name = "Email Notification"
  type         = "email"

  labels = {
    email_address = var.alert_email
  }
}

