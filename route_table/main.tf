variable "bastion_vpc_id" {}
variable "deployment_vpc_id" {}
variable "bastion_igw_id" {}
variable "deployment_igw_id" {}
variable "nat_id" {}
variable "public_subnet_id" {}
variable "bastion_subnet_id" {}
variable "nlb_public_subnet_id" {}
variable "nlb_public_subnet_id_b" {}
variable "nlb_private_subnet_id" {}
variable "nlb_private_subnet_id_b" {}
variable "maven_private_subnet_id" {}
variable "nginx_private_subnet_id" {}
variable "app_private_subnet_id" {}
variable "database_private_subnet_id" {}
variable "nginx_private_subnet_id_1b" {}
variable "app_private_subnet_id_1b" {}
variable "database_private_subnet_id_1b" {}
variable "transit_gateway_id" {}




# Create a route table

# public route for bastion host
resource "aws_route_table" "bastion_route_table" {
  vpc_id = var.bastion_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.bastion_igw_id
  }
  route {
    cidr_block = "172.32.0.0/16"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "bastion-route-table"
  }
}

resource "aws_route_table_association" "bastion_Association_table" {
  subnet_id = var.bastion_subnet_id
  route_table_id = aws_route_table.bastion_route_table.id
}




# public route for public subnet
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.deployment_igw_id
  }

  tags = {
    Name = "bastion-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_Association_table" {
  subnet_id = var.public_subnet_id
  route_table_id = aws_route_table.public_subnet_route_table.id
}


# public route for nlb public subnet
resource "aws_route_table" "nlb_subnet_route_table" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.deployment_igw_id
  }
  route {
    cidr_block = "192.168.0.0/16"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "nlb-public-subnet-route-table"
  }
}

resource "aws_route_table_association" "nlb_subnet_Association_table" {
  subnet_id = var.nlb_public_subnet_id
  route_table_id = aws_route_table.nlb_subnet_route_table.id
}

resource "aws_route_table" "nlb_subnet_route_table_b" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.deployment_igw_id
  }
  route {
    cidr_block = "192.168.0.0/16"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "nlb-public-subnet-route-table-b"
  }
}

resource "aws_route_table_association" "nlb_subnet_Association_table_b" {
  subnet_id = var.nlb_public_subnet_id_b
  route_table_id = aws_route_table.nlb_subnet_route_table_b.id
}

# private route for nginx server
resource "aws_route_table" "nginx_private_route_table" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }
  route {
    cidr_block = "192.168.0.0/16"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "nginx-private-route-table"
  }
}



resource "aws_route_table_association" "nginx_private_Association_table" {
  subnet_id = var.nginx_private_subnet_id
  route_table_id = aws_route_table.nginx_private_route_table.id
}


# private route for nginx server for AZ 1b
resource "aws_route_table" "nginx_private_route_table_1b" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }
  route {
    cidr_block = "192.168.0.0/16"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "nginx-private-route-table-1b"
  }
}



resource "aws_route_table_association" "nginx_private_Association_table_1b" {
  subnet_id = var.nginx_private_subnet_id_1b
  route_table_id = aws_route_table.nginx_private_route_table_1b.id
}


# public route for nlb private subnet
resource "aws_route_table" "nlb_private_subnet_route_table" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.deployment_igw_id
  }

  tags = {
    Name = "nlb-private-subnet-route-table"
  }
}

resource "aws_route_table_association" "nlb_private_subnet_Association_table" {
  subnet_id = var.nlb_private_subnet_id
  route_table_id = aws_route_table.nlb_private_subnet_route_table.id
}

resource "aws_route_table" "nlb_private_subnet_route_table_b" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.deployment_igw_id
  }

  tags = {
    Name = "nlb-private-subnet-route-table_b"
  }
}

resource "aws_route_table_association" "nlb_private_subnet_Association_table_b" {
  subnet_id = var.nlb_private_subnet_id_b
  route_table_id = aws_route_table.nlb_private_subnet_route_table_b.id
}

# private route for app server
resource "aws_route_table" "app_private_route_table" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }
  route {
    cidr_block = "192.168.0.0/16"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "app-private-route-table"
  }
}



resource "aws_route_table_association" "app_private_Association_table" {
  subnet_id = var.app_private_subnet_id
  route_table_id = aws_route_table.app_private_route_table.id
}


# private route for app server for AZ 1b
resource "aws_route_table" "app_private_route_table_1b" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }
  route {
    cidr_block = "192.168.0.0/16"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "app-private-route-table-1b"
  }
}



resource "aws_route_table_association" "app_private_Association_table_1b" {
  subnet_id = var.app_private_subnet_id_1b
  route_table_id = aws_route_table.app_private_route_table_1b.id
}



# private route for database server
resource "aws_route_table" "database_private_route_table" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }

  tags = {
    Name = "database-private-route-table"
  }
}



resource "aws_route_table_association" "database_private_Association_table" {
  subnet_id = var.database_private_subnet_id
  route_table_id = aws_route_table.database_private_route_table.id
}


# private route for database server for AZ 1b
resource "aws_route_table" "database_private_route_table_1b" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }

  tags = {
    Name = "database-private-route-table-1b"
  }
}



resource "aws_route_table_association" "database_private_Association_table_1b" {
  subnet_id = var.database_private_subnet_id_1b
  route_table_id = aws_route_table.database_private_route_table_1b.id
}

# private route for maven server
resource "aws_route_table" "maven_private_route_table" {
  vpc_id = var.deployment_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }
  route {
    cidr_block = "192.168.0.0/16"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "maven-private-route-table"
  }
}



resource "aws_route_table_association" "maven_private_Association_table" {
  subnet_id = var.maven_private_subnet_id
  route_table_id = aws_route_table.maven_private_route_table.id
}