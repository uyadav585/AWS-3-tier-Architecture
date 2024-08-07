variable "nginx_nlb_id" {}
variable "nginx_nlb_id_b" {}
variable "nginx_nlb_sg_id" {}
variable "nginx_target_group_arn" {}

variable "nlb_private_subnet_id" {}
variable "nlb_private_subnet_id_b" {}
variable "tomcat_nlb_sg_id" {}
variable "tomcat_target_group_arn" {}


# public NLB integrated with private subnet

# Create a Network Load Balancer
resource "aws_lb" "nginx_nlb" {
  name               = "nginx-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [ var.nginx_nlb_id, var.nginx_nlb_id_b]
  security_groups    = [var.nginx_nlb_sg_id]
  

  enable_deletion_protection = false

  tags = {
    Name = "nginx-nlb"
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.nginx_nlb.arn
  port              = "80"
  protocol          = "TCP"
  
  default_action {
    type             = "forward"
    target_group_arn = var.nginx_target_group_arn
  }
}

output "nlb_nginx_dns_name" {
  value = aws_lb.nginx_nlb.dns_name
}


# Create a Network Load Balancer for tomcat server

resource "aws_lb" "tomcat_nlb" {
  name               = "tomcat-nlb"
  internal           = true      # true for private facing fasle for public facing
  load_balancer_type = "network"
  subnets            = [var.nlb_private_subnet_id, var.nlb_private_subnet_id_b ]
  security_groups    = [var.tomcat_nlb_sg_id]
 
  tags = {
    Name = "tomcat-nlb"
  }
}


resource "aws_lb_listener" "tomcat_front_end" {
  load_balancer_arn = aws_lb.tomcat_nlb.arn
  port              = "9090"
  protocol          = "TCP"
  
  default_action {
    type             = "forward"
    target_group_arn = var.tomcat_target_group_arn
  }
}

output "nlb_tomcat_dns_name" {
  value = aws_lb.tomcat_nlb.dns_name
}