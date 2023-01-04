################################################################################
# VPC - main.tf
################################################################################

locals {
  name_suffix = "${var.project_name}-${var.environment}"
}

locals {
required_tags = {
    project     = var.project_name,
    environment = var.environment
  }
}

locals {
  subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
  }
}

provider "aws" {
  region = var.region
}

module "vpc" { 
  source  = var.source
  version = "~> 3.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

    azs             = var.azs
    private_subnets = var.private_subnets
    public_subnets  = var.public_subnets


###################################################################
#               Public Subnet & Networking
###################################################################

    #Internet gateway for the public subnet
    aws_internet_gateway igw = {
        vpc_id = aws_vpc.vpc.id

        tags = merge(local.tags, { Name = "Internet-Gateway" })
        tags = merge(local.tags, local.subnet_tags)
    }

    #Public subnet
    aws_subnet public_subnet = {
        vpc_id                  = aws_vpc.vpc.id
        for_each                = var.public_subnets
        availability_zone       = each.key
        cidr_block              = each.value
        map_public_ip_on_launch = "true" #makes this a public subnet

        tags = merge(local.tags, { Name = "Public-Subnet" })
        tags = merge(local.tags, local.subnet_tags)
    }

    #Route table for public subnet
    aws_route_table public = {
        vpc_id = aws_vpc.vpc.id

        tags = merge(local.tags, { Name = "Public-Route-Table" })
        tags = merge(local.tags, local.subnet_tags)
    }

    #aws_route adds a route to the aws_route_table
    aws_route public_internet_gateway = {
        route_table_id         = aws_route_table.public.id
        destination_cidr_block = var.destination_cidr_block
        gateway_id             = aws_internet_gateway.igw.id
        tags = merge(local.tags, local.subnet_tags)
    }

    #Route table associations
    aws_route_table_association public = {
        for_each       = var.public_subnets
        subnet_id      = aws_subnet.public_subnets[each.key].id
        route_table_id = aws_route_table.public.id
        tags = merge(local.tags, local.subnet_tags)
    }


###################################################################
#               Private Subnet & Networking
###################################################################

    #Private subnet
    aws_subnet private_subnet = {
        vpc_id                  = aws_vpc.vpc.id
        for_each                = var.private_subnets
        availability_zone       = each.key
        cidr_block              = each.value

        tags = merge(local.tags, { Name = "Private-Subnet" })
        tags = merge(local.tags, local.subnet_tags)
    }

    # Route table for Private subnet
    aws_route_table private = {
        vpc_id = aws_vpc.vpc.id


        tags = merge(local.tags, { Name = "Private-Route-Table" })
        tags = merge(local.tags, local.subnet_tags)
    }

    #Route table associations
    aws_route_table_association private = {
        for_each       = var.private_subnets
        subnet_id      = aws_subnet.private_subnets[each.key].id
        route_table_id = aws_route_table.private.id

        tags = merge(local.tags, local.subnet_tags)
    }

}
