#Define target group#
resource "aws_alb_target_group" "ju-tg-tf" {
  name = "vc-tg-tf"
  port = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = aws_vpc.ju-vpc-tf.id

  health_check {
    interval = 10
    path = "/"
    protocol = "HTTP"
    timeout = 5
    healthy_threshold = 5
    unhealthy_threshold = 2

  }
}

#Define ALB#
resource "aws_alb" "ju-alb-tf" {
  name = "vc-alb-tf"
  internal = false

  subnets = [
    aws_subnet.ju-sub-pub.id,
    aws_subnet.ju-sub-pub2.id
  ]
  security_groups = [aws_security_group.ju-ssh-tf.id]
  tags = {
    Name ="ju-alb-tf"
  }
  ip_address_type = "ipv4"
  load_balancer_type = "application"



}

#Define Listener#
resource "aws_lb_listener" "ju-list-alb-tf" {
  load_balancer_arn = aws_alb.ju-alb-tf.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.ju-tg-tf.arn
  }
}
