variable "nginx_server_id" {}
variable "nginx_subnet_id" {}
variable "nginx_subnet_1b_id" {}
variable "nginx_target_group_arn" {}

variable "tomcat_server_id" {}
variable "tomcat_subnet_id" {}
variable "tomcat_subnet_1b_id" {}
variable "tomcat_target_group_arn" {}
variable "depends_on_database" {}



resource "aws_autoscaling_group" "nginx_aws_autoscaling" {
  depends_on = [ var.depends_on_database ]
  #availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 5
  min_size           = 1

  launch_template {
    id      = var.nginx_server_id  # aws_launch_template.nginx_server.id
    version = "$Latest"
  }
  vpc_zone_identifier = [ var.nginx_subnet_id, var.nginx_subnet_1b_id ]
}



# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "nginx-target-group-attachment" {
  autoscaling_group_name = aws_autoscaling_group.nginx_aws_autoscaling.id
  lb_target_group_arn    = var.nginx_target_group_arn
}



resource "aws_autoscaling_group" "aws_autoscaling_tomcat" {
  depends_on = [ var.depends_on_database ]
  #availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 5
  min_size           = 1

  launch_template {
    id      = var.tomcat_server_id
    version = "$Latest"
  }
  vpc_zone_identifier = [ var.tomcat_subnet_id, var.tomcat_subnet_1b_id ]
}



# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "target-group-attachment_tomcat" {
  autoscaling_group_name = aws_autoscaling_group.aws_autoscaling_tomcat.id
  lb_target_group_arn    = var.tomcat_target_group_arn
}
