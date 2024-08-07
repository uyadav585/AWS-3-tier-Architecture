variable "deployment_vpc_id" {}



# Define a Target Group for NLB
resource "aws_lb_target_group" "nginx_target_group" {
  name     = "nginx-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = var.deployment_vpc_id
  health_check {
    protocol = "HTTP"
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

}

output "nginx_target_group_arn" {
  value = aws_lb_target_group.nginx_target_group.arn
}

# Define a Target Group for NLB
resource "aws_lb_target_group" "tomcat_target_group" {
  name     = "tomcat-target-group"
  port     = 9090
  protocol = "TCP"
  vpc_id   = var.deployment_vpc_id
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

output "tomcat_target_group_arn" {
  value = aws_lb_target_group.tomcat_target_group.arn
}