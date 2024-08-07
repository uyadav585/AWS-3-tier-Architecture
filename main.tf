terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


# All the modules are being called

module "vpc" {
  source = "./vpc"
}

module "subnet" {
  source = "./subnets"
  bastion_vpc_id = module.vpc.bastion_vpc_id
  deployment_vpc_id = module.vpc.deployment_vpc_id
}

module "security_groups" {
  source = "./security_groups"
  deployment_vpc_id = module.vpc.deployment_vpc_id
  bastion_vpc_id = module.vpc.bastion_vpc_id
}

module "igw" {
  source = "./IGW"
  bastion_vpc_id = module.vpc.bastion_vpc_id
  deployment_vpc_id = module.vpc.deployment_vpc_id
}

module "eip" {
  source = "./elasticIP"
}

module "nat" {
  source = "./NAT"
  public_subnet_id = module.subnet.public_subnet_id
  allocation_id = module.eip.allocation_id
}

module "route_table" {
  source = "./route_table"
  bastion_vpc_id = module.vpc.bastion_vpc_id
  deployment_vpc_id = module.vpc.deployment_vpc_id
  public_subnet_id = module.subnet.public_subnet_id
  bastion_subnet_id = module.subnet.bastion_subnet_id
  nlb_public_subnet_id = module.subnet.nlb_subnet_id
  nlb_public_subnet_id_b = module.subnet.nlb_subnet_id_b
  nlb_private_subnet_id = module.subnet.nlb_private_subnet_id
  nlb_private_subnet_id_b = module.subnet.nlb_private_subnet_id_b
  nginx_private_subnet_id = module.subnet.nginx_subnet_id
  nginx_private_subnet_id_1b = module.subnet.nginx_subnet_id_1b
  app_private_subnet_id = module.subnet.app_subnet_id
  app_private_subnet_id_1b = module.subnet.app_subnet_id_1b
  maven_private_subnet_id = module.subnet.maven_subnet_id
  database_private_subnet_id = module.subnet.database_subnet_id
  database_private_subnet_id_1b = module.subnet.database_subnet_id_1b 
  bastion_igw_id = module.igw.bastion_igw_id
  deployment_igw_id = module.igw.deployment_igw_id
  nat_id = module.nat.nat_id
  transit_gateway_id = module.transitGW.transit_gateway_id
}



module "transitGW" {
  source = "./transit_gateway"
  bastion_vpc_id = module.vpc.bastion_vpc_id
  deployment_vpc_id = module.vpc.deployment_vpc_id
  bastion_subnet_id = module.subnet.bastion_subnet_id
  nginx_private_subnet_id = module.subnet.nginx_subnet_id
  nginx_private_subnet_id_1b = module.subnet.nginx_subnet_id_1b
}

module "network-load-Balancer" {
  source = "./netwrok-load-balancer"

  nginx_nlb_id = module.subnet.nlb_subnet_id
  nginx_nlb_id_b = module.subnet.nlb_subnet_id_b
  nginx_nlb_sg_id = module.security_groups.nginx_nlb_sg_id
  nginx_target_group_arn = module.target-group.nginx_target_group_arn

  nlb_private_subnet_id = module.subnet.nlb_private_subnet_id
  nlb_private_subnet_id_b = module.subnet.nlb_private_subnet_id_b
  tomcat_nlb_sg_id = module.security_groups.tomcat_nlb_sg_id
  tomcat_target_group_arn = module.target-group.tomcat_target_group_arn
}

module "autoscaling" {
  source = "./auto-scaling"
  depends_on_database = module.database.database_name

  nginx_server_id = module.launch-template.nginx_server_id
  nginx_subnet_id = module.subnet.nginx_subnet_id
  nginx_subnet_1b_id = module.subnet.nginx_subnet_id_1b
  nginx_target_group_arn = module.target-group.nginx_target_group_arn 

  tomcat_subnet_id = module.subnet.app_subnet_id
  tomcat_subnet_1b_id = module.subnet.app_subnet_id_1b
  tomcat_server_id = module.launch-template.tomcat_server_id
  tomcat_target_group_arn = module.target-group.tomcat_target_group_arn
}

module "launch-template" {
  source = "./launch-template"

  nginx_sg_id = module.security_groups.nginx_sg_id

  tomcat_sg_id = module.security_groups.tomcat_sg_id
  database_sg_id = module.security_groups.database_sg_id
  nlb_tomcat_dns_name = module.network-load-Balancer.nlb_tomcat_dns_name

  maven_subnet_id = module.subnet.maven_subnet_id
  maven_sg_id = module.security_groups.maven_sg_id
}

module "target-group" {
  source = "./target_group"
  deployment_vpc_id = module.vpc.deployment_vpc_id
}

module "bastion-instance" {
  source = "./bastion-instance"
  bastion_sg_id = module.security_groups.bastion_sg_id
  bastion_subnet_id = module.subnet.bastion_subnet_id
}

module "database" {
  source = "./database-instance"
  database_private_subnet_id = module.subnet.database_subnet_id
  database_private_subnet_id_1b = module.subnet.database_subnet_id_1b
  database_sg_id = module.security_groups.database_sg_id
  tomcat_sg_id = module.security_groups.tomcat_sg_id
}