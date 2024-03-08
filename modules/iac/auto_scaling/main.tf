resource "aws_autoscaling_group" "auto" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = [var.subnet_id]
  launch_configuration = aws_launch_configuration.auto.name

  tag {
    key                 = "Name"
    value               = "auto"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "auto" {
  name_prefix   = "auto-lc"
  image_id      = var.image_id
  instance_type = var.instance_type

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.auto.name
}