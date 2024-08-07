# vpc id
variable "bastion_vpc_id" {}
variable "deployment_vpc_id" {}


# Create public subnet for bastion host
resource "aws_subnet" "bastion_subnet" {
  vpc_id                  = var.bastion_vpc_id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "bastion-subnet"
  }
}

output "bastion_subnet_id" {
  value = aws_subnet.bastion_subnet.id
}


# Create public subnet for internet access to the private subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "public-subnet"
  }
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

# Create public subnet for NLB for nginx server
resource "aws_subnet" "nlb_public_subnet" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "NLB-public-subnet"
  }
}

output "nlb_subnet_id" {
  value = aws_subnet.nlb_public_subnet.id
}

resource "aws_subnet" "nlb_public_subnet_b" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.11.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "NLB-public-subnet-b"
  }
}

output "nlb_subnet_id_b" {
  value = aws_subnet.nlb_public_subnet_b.id
}

# Create private subnet for nginx
resource "aws_subnet" "nginx_private_subnet" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "nginx-private-subnet-1a"
  }
}

output "nginx_subnet_id" {
  value = aws_subnet.nginx_private_subnet.id
}


# Create private subnet for nginx for AZ 1b
resource "aws_subnet" "nginx_private_subnet_1b" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "nginx-private-subnet-1b"
  }
}

output "nginx_subnet_id_1b" {
  value = aws_subnet.nginx_private_subnet_1b.id
}


# Create public subnet for NLB for nginx server
resource "aws_subnet" "nlb_private_subnet" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "NLB-private-subnet"
  }
}

output "nlb_private_subnet_id" {
  value = aws_subnet.nlb_private_subnet.id
}

resource "aws_subnet" "nlb_private_subnet_b" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.12.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "NLB-private-subnet-b"
  }
}

output "nlb_private_subnet_id_b" {
  value = aws_subnet.nlb_private_subnet_b.id
}

# Create private subnet for app
resource "aws_subnet" "app_private_subnet" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "app-private-subnet-1a"
  }
}

output "app_subnet_id" {
  value = aws_subnet.app_private_subnet.id
}


# Create private subnet for app for AZ 1b
resource "aws_subnet" "app_private_subnet_1b" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.7.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "app-private-subnet-1b"
  }
}

output "app_subnet_id_1b" {
  value = aws_subnet.app_private_subnet_1b.id
}


# Create private subnet for data base
resource "aws_subnet" "database_private_subnet" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.8.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "database-private-subnet-1a"
  }
}

output "database_subnet_id" {
  value = aws_subnet.database_private_subnet.id
}


# Create private subnet for data base for AZ 1b
resource "aws_subnet" "database_private_subnet_1b" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.9.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "database-private-subnet-1b"
  }
}

output "database_subnet_id_1b" {
  value = aws_subnet.database_private_subnet_1b.id
}


# Create private subnet for maven
resource "aws_subnet" "maven_private_subnet" {
  vpc_id                  = var.deployment_vpc_id
  cidr_block              = "172.32.10.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "maven-private-subnet-1a"
  }
}

output "maven_subnet_id" {
  value = aws_subnet.maven_private_subnet.id
}