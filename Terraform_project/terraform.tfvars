billing_code                    = "ACT8675309"
project                         = "web-app"
lb_name                         = "web-app-lb"
lb_type                         = "application"
lb_target_group_name            = "web-app-lb-tg"
lb_target_group_port            = 80
lb_target_group_protocol        = "HTTP"
lb_listener_port                = 80
lb_listener_protocol            = "HTTP"
lb_target_group_attachment_port = 80
apache_lb_sg_name               = "apache-lb-sh"
apache_sg_name                  = "apache-sg"
subnets_cidr                    = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
