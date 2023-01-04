################################################################################
# EKS - eks.tfvars
################################################################################

region      = "eu-west-2"
project_name = "eks-aws-terraform-module"
environment = "dev"
source = "terraform-aws-modules/eks/aws"
cluster_name = "eks-cluster-1"
cluster_version = "1.24"
ami_type = "AL2_x86_64"
worker_one = "node-group-1"
worker_two = "node-group-2"
instance_type = "t2.nano"
capacity_type = "SPOT"
