################################################################################
# VPC - vpc.tfvars
################################################################################

project_name = "eks-aws-terraform-module"
environment = "dev"
source = "terraform-aws-modules/vpc/aws"
region      = "eu-west-2"
vpc_name = "VPC-Dev"
vpc_cidr = "10.0.0.0/16"
azs = [
  "eu-west-2a"
  "eu-west-2b"
  "eu-west-2c",
]
private_subnets = {
  "eu-west-2a" : "10.0.1.0/24",
  "eu-west-2b" : "10.0.2.0/24",
  "eu-west-2c" : "10.0.3.0/24"
}
public_subnets = {
  "eu-west-2a" : "10.0.4.0/24",
  "eu-west-2b" : "10.0.5.0/24",
  "eu-west-2c" : "10.0.6.0/24"
}
destination_cidr_block = "0.0.0.0/0"
