resource "aws_cloudwatch_log_group" "app-logs" {
  name              = "/ec2/app-logs"
  retention_in_days = 7
}

# CloudWatch Alarm for System Health
resource "aws_cloudwatch_metric_alarm" "system_health" {
  alarm_name          = "SystemHealthAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_actions       = [var.sns_topic_arn]
  dimensions = {
    InstanceId = var.InstanceId
  }
}

# # CloudWatch Alarm for Application Health
resource "aws_cloudwatch_metric_alarm" "app_health" {
  alarm_name          = "AppHealthAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_Backend_5XX"
  namespace           = "AWS/ELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    LoadBalancerName = var.load_balancer_name
  }
}
