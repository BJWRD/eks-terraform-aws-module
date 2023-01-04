################################################################################
# EKS - eks.tf
################################################################################

module "eks" {
  source          = terraform-aws-modules/eks/aws

  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version

  subnet_id       = module.vpc.subnet_id
  vpc_id          = module.vpc.vpc_id
  cluster_endpoint_public_access = true
  
  eks_managed_node_group_defaults = {
    ami_type = var.ami_type

  }

  eks_managed_node_groups = {
    worker_one = {
      node_group_1 = var.worker_one

      instance_types = var.instance_types

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
    tags = local.tags

    worker_two = {
      name = var.worker_two

      instance_types = var.instance_types
      capacity_type = var.capacity_type

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
    tags = local.tags
  }
}
