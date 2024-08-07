variable "deployment_vpc_id" {}
variable "bastion_vpc_id" {}




# Create a security group for NLB
resource "aws_security_group" "nginx_nlb_sg" {
  vpc_id = var.deployment_vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nginx-nlb-sg"
  }
}

output "nginx_nlb_sg_id" {
  value = aws_security_group.nginx_nlb_sg.id
}


resource "aws_security_group" "nginx_sg" {
  vpc_id = var.deployment_vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nginx-sg"
  }
}

output "nginx_sg_id" {
  value = aws_security_group.nginx_sg.id
}

resource "aws_security_group" "tomcat_sg" {
  vpc_id = var.deployment_vpc_id
  ingress {
    from_port   = 8125
    to_port     = 8125
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "tomcat-sg"
  }
}

output "tomcat_sg_id" {
  value = aws_security_group.tomcat_sg.id
}


resource "aws_security_group" "tomcat_nlb_sg" {
  vpc_id = var.deployment_vpc_id

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "tomcat-nlb-sg"
  }
}

output "tomcat_nlb_sg_id" {
  value = aws_security_group.tomcat_nlb_sg.id
}


resource "aws_security_group" "maven_sg" {
  vpc_id = var.deployment_vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "maven-sg"
  }
}

output "maven_sg_id" {
  value = aws_security_group.maven_sg.id
}


resource "aws_security_group" "bastion_sg" {
  vpc_id = var.bastion_vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion-sg"
  }
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}



resource "aws_security_group" "database_sg" {
  vpc_id = var.deployment_vpc_id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [ aws_security_group.tomcat_sg.id ]
  }

  tags = {
    Name = "example-sg"
  }
}

output "database_sg_id" {
  value = aws_security_group.database_sg.id
}

