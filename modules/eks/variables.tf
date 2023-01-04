################################################################################
# EKS - variables.tf
################################################################################

variable "region" {
  description = "This is the cloud hosting region where your webapp will be deployed."
}

variable "project_name" {
    description = "Name of Project"
}

variable "environment" {
    description = "Environment type"
}

variable "source" {
    description = "Source Code"
}

variable "cluster_name" {
  description = "Name of Cluster"
}

variable "cluster_version" {
  description = "Cluster Version"
}

variable "ami_type" {
  description = "The Machine Image of the EKS Cluster"
}

variable "worker_one" {
  description = "The first Node Worker Group"
}

variable "worker_two" {
  description = "The second Node Worker Group"
}

variable "instance_type" {
  description = "AWS Instance Type"
}

varaible "capacity_type" {
  description = "AWS Instance Capacity Type"
}
