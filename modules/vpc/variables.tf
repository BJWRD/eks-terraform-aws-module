################################################################################
# VPC - variables.tf
################################################################################

variable "project_name" {
    description = "Name of Project"
}

variable "environment" {
    description = "Environment type"
}

variable "source" {
    description = "Source Code"
}

variable "region" {
  description = "This is the cloud hosting region where your webapp will be deployed."
}

variable "vpc_name" {
    description = "Name of VPC"
}

variable "vpc_cidr" {
    description = "CIDR Range"
}

variable "azs" {
    description = "Availability Zones"
}

variable "private_subnets" {
    description = "Private Subnet Range"
}

variable "public_subnets" {
    description = "Public Subnet Range"
}

variable "destination_cidr_block" {
    description = "The CIDR Block Desination"
}
