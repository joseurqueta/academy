#Define autoscaling group#
resource "aws_autoscaling_group" "ju-asg-tf" {
  name = "ju-asg-tf"
  max_size = 3
  min_size = 0
  desired_capacity = 2
  launch_template {
    name= aws_launch_template.ju-lt-tf.name
    version = "$Latest"

  }
  #Define AZ#
  vpc_zone_identifier = [aws_subnet.ju-sub-pub.id,aws_subnet.ju-sub-pub2.id]
  target_group_arns = [aws_alb_target_group.ju-tg-tf.arn]
  health_check_type = "EC2"
  tag {
    key = "Name"
    propagate_at_launch = true
    value = "ju_asg-tf"
  }
}