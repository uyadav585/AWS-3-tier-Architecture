variable "bastion_vpc_id" {}
variable "deployment_vpc_id" {}



# Internet Gateway for bastion vpc
resource "aws_internet_gateway" "bastion_igw" {
  vpc_id = var.bastion_vpc_id


  tags = {
    Name = "bastion-igw"
  }
}


output "bastion_igw_id" {
  value = aws_internet_gateway.bastion_igw.id
}


# Internet Gateway for deployment vpc
resource "aws_internet_gateway" "deployment_igw" {
  vpc_id = var.deployment_vpc_id


  tags = {
    Name = "deployment-igw"
  }
}


output "deployment_igw_id" {
  value = aws_internet_gateway.deployment_igw.id
}