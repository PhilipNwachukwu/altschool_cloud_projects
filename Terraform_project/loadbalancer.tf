# aws_elb_service_account

# aws_lb
resource "aws_lb" "apache" {
  name               = var.lb_name
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.lb-sg.id]
  subnets            = aws_subnet.subnet.*.id
  # [aws_subnet.subnet.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]

  enable_deletion_protection = false

  tags = local.common_tags

}
# aws_lb_target_group
resource "aws_lb_target_group" "apache_lb_tg" {
  name     = var.lb_target_group_name
  port     = var.lb_target_group_port
  protocol = var.lb_target_group_protocol
  vpc_id   = aws_vpc.vpc.id

  tags = local.common_tags
}
# aws_lb_listener
resource "aws_lb_listener" "apache_lb_listener" {
  load_balancer_arn = aws_lb.apache.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache_lb_tg.arn
  }

  tags = local.common_tags
}
# aws_lb_target_group_attachment

resource "aws_lb_target_group_attachment" "web_server" {

  count            = length(aws_instance.web_server)
  target_group_arn = aws_lb_target_group.apache_lb_tg.arn
  target_id        = element(aws_instance.web_server.*.id, count.index)
  port             = var.lb_target_group_attachment_port
}
