variable "bastion_vpc_id" {}
variable "deployment_vpc_id" {}
variable "bastion_subnet_id" {}
variable "nginx_private_subnet_id" {}
variable "nginx_private_subnet_id_1b" {}


resource "aws_ec2_transit_gateway" "transit" {
  description = "transit for all ec2"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags = {
    Name = "transit-gateway"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "bastion-vpc-attachment" {
  vpc_id = var.bastion_vpc_id
  transit_gateway_id = aws_ec2_transit_gateway.transit.id
  subnet_ids = [ var.bastion_subnet_id ]
  tags = {
    Name = "transit attachment with vpc id-${var.bastion_vpc_id}"
  }
  
}


resource "aws_ec2_transit_gateway_vpc_attachment" "deployment-vpc-attachment" {
  vpc_id = var.deployment_vpc_id
  transit_gateway_id = aws_ec2_transit_gateway.transit.id
  subnet_ids = [ var.nginx_private_subnet_id, var.nginx_private_subnet_id_1b ]
  tags = {
    Name = "transit attachment with vpc id-${var.deployment_vpc_id}"
  }
}


resource "aws_ec2_transit_gateway_route_table" "transit-gateway" {
  transit_gateway_id = aws_ec2_transit_gateway.transit.id
  tags = {
    Name = "transit route table"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "bastion-route" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.bastion-vpc-attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.transit-gateway.id
}

resource "aws_ec2_transit_gateway_route_table_association" "deployment-route" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.deployment-vpc-attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.transit-gateway.id
}

resource "aws_ec2_transit_gateway_route" "bastion-deployment" {
  destination_cidr_block         = "192.168.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.bastion-vpc-attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.transit-gateway.id
}

resource "aws_ec2_transit_gateway_route" "deployment-bastion" {
  destination_cidr_block         = "172.32.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.deployment-vpc-attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.transit-gateway.id
}



output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.transit.id
}