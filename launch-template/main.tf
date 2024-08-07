variable "nginx_sg_id" {}
variable "tomcat_sg_id" {}
variable "nlb_tomcat_dns_name" {}
variable "maven_subnet_id" {}
variable "maven_sg_id" {}
variable "database_sg_id" {}


data "template_file" "user-data" {
  template = file("${path.module}/user_data.sh")

  vars = {
    backend_url = var.nlb_tomcat_dns_name
  }
}

resource "aws_launch_template" "nginx_server" {
  name = "nginx-server"
  description = "testing nginx ami"
  image_id = "ami-01221295ef7a8f493"
  instance_type = "t2.micro"
  key_name = "java-project"
  vpc_security_group_ids = [ var.nginx_sg_id ]
  
  user_data = base64encode(data.template_file.user-data.rendered)
}

output "nginx_server_id" {
  value = aws_launch_template.nginx_server.id
}

data "template_file" "tomcat-user-data" {
  template = file("${path.module}/tomcat_user_data.sh")
}

resource "aws_launch_template" "tomcat_server" {
  name = "tomcat-server"
  description = "testing tomcat ami"
  image_id = "ami-0bf1e75d06d8b3b4b"
  instance_type = "t2.micro"
  key_name = "java-project"
  vpc_security_group_ids = [ var.tomcat_sg_id,var.database_sg_id ]

  user_data = base64encode(data.template_file.tomcat-user-data.rendered)
}

output "tomcat_server_id" {
  value = aws_launch_template.tomcat_server.id
}

data "template_file" "maven-user-data" {
  template = file("${path.module}/maven_user_data.sh")
}

resource "aws_instance" "maven_instance" {
  ami           = "ami-030afe029c5bb13df"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = var.maven_subnet_id
  security_groups = [var.maven_sg_id]
  key_name = "java-project"
  
  user_data = base64encode(data.template_file.maven-user-data.rendered)
  tags = {
    Name = "maven-instance"
  }
}