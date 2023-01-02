provider "aws" {
  region = "eu-west-2"
}

module "eks" {
  source                 = "./modules/eks"
}

module "vpc" {
  source                      = "./modules/vpc"
  vpc_id                      = var.vpc_id
  vpc_cidr                    = var.vpc_cidr
  availability_zones          = var.availability_zones
  route_table_id              = var.route_table_id
  gateway_id                  = var.gateway_id
  destination_cidr_block      = var.destination_cidr_block
  aws_subnet_public_subnet    = var.aws_subnet_public_subnet
  aws_subnet_private_subnet   = var.aws_subnet_private_subnet
  load_balancer_type          = var.load_balancer_type
  id_app                      = module.ec2.id_app
  security_group_alb_app_http = module.security.security_group_alb_app_http
  subnet_id                   = var.subnet_id
  az_public_subnet            = var.az_public_subnet
  az_private_subnet           = var.az_private_subnet
  app_alb_lb                  = var.app_alb_lb
  app_target_group            = var.app_target_group
  app_autoscaling_group       = var.app_autoscaling_group
  project_name                = var.project_name
  environment                 = var.environment
}
