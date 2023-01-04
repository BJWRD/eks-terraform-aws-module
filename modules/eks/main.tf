################################################################################
# EKS - main.tf
################################################################################

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
  region = var.region
}

locals {
  name_suffix = "${var.project_name}-${var.environment}"
}

locals {
required_tags = {
    project     = var.project_name,
    environment = var.environment
  }
  cluster_name = var.cluster_name
}
