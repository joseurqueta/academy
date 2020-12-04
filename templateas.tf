#Define launch template for the autoscaling#
resource "aws_launch_template" "ju-lt-tf" {
  name = "ju-lt-tf"
  description = "Template from terraform"
  image_id = var.ami
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.instance_type
  key_name = "joseu-academy"
  default_version = 1
  user_data = filebase64("${path.module}/install_apache.sh")



  network_interfaces {
    associate_public_ip_address = "true"
    security_groups = [aws_security_group.ju-ssh-tf.id]

  }

  tags = {
    Name = "ju_lt_tf"
  }

}
