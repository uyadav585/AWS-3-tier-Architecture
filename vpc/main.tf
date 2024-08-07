#create variable for cidr
variable "bastion_vpc_cidr" {
  default = "192.168.0.0/16"
  }
variable "deployment_vpc_cidr" {
  default = "172.32.0.0/16"
  }


# Create a VPC for bastion host
resource "aws_vpc" "Bastion_vpc" {
  cidr_block       = var.bastion_vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "bastion-host-vpc"
  }
}

# Create a VPC for deploying Highly Available and Auto Scalable application servers
resource "aws_vpc" "deployment_vpc" {
  cidr_block       = var.deployment_vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "deployment-vpc"
  }
}

output "bastion_vpc_id" {
  value = aws_vpc.Bastion_vpc.id
  }

output "deployment_vpc_id" {
  value = aws_vpc.deployment_vpc.id
}
