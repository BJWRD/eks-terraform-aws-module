# eks-terraform-aws-module
EKS Cluster including three Nodes provisioned by Terraform, hosted on AWS Public Cloud.

# Architecture
![image](https://user-images.githubusercontent.com/83971386/211145281-4db216e1-733c-49c7-ade9-7985ebe62a06.png)

**Note:** - The following architecture doesn't reflect all the components that are created by this template. However, it does provide a high-level overview of the core infrastructure that will be created.

# Prerequisites
* An AWS Account with an IAM user capable of creating resources – `AdminstratorAccess`
* A locally configured AWS profile for the above IAM user
* Terraform installation - [steps](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* AWS EC2 key pair - [steps](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
* Environment Variables for AWS CLI - [steps](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

# How to Apply/Destroy
This section details the deployment and teardown of the three-tier-architecture. **Warning: this will create AWS resources that costs money**

## Deployment steps

### Applying the Terraform Configuration

#### 1.	Clone the repo

    git clone https://github.com/BJWRD/eks-terraform-aws-module

#### 2.	Initialise the TF directory

    terraform init

#### 3.	 Ensure the terraform code is formatted and validated 

    terraform fmt && terraform validate

#### 4.	Create an execution plan

    terraform plan

#### 5.	Execute terraform configuration - Creating the EKS Cluster

    terraform apply --auto-approve
    
<img width="530" alt="image" src="https://user-images.githubusercontent.com/83971386/211190243-233abc05-3ab5-4290-a613-71ba0938c36c.png">

### Further Configuration
Once the Resources have been successfully provisioned, you will then be able to configure kubectl to manage your cluster and deploy Kubernetes configurations to it.

#### 1. Configure Kubectl 

    aws eks --region <AWS-REGION> update-kubeconfig --name <CLUSTER-NAME>
    
<img width="829" alt="image" src="https://user-images.githubusercontent.com/83971386/211190779-d12804a1-22f1-4017-bc3f-4f798bbf548c.png">

**NOTE:** If you receive the following error message when attempting to configure the Kubectl remove the existing kube config file and you should then be able to proceed - `~/.kube/config` 

<img width="835" alt="image" src="https://user-images.githubusercontent.com/83971386/211190758-57979787-0626-4061-9c7a-b1d05caf2cec.png">

## Verification Steps 

#### 1. Verify the Cluster

    kubectl cluster-info
    
<img width="720" alt="image" src="https://user-images.githubusercontent.com/83971386/211192392-58ba2350-5f7b-4d46-8668-83b2ddd6f194.png">

**NOTE:** If you receive the error message below when attempting to view the Cluster Information, review the following Github forum page for further advice - https://github.com/hashicorp/terraform-provider-helm/issues/893

<img width="438" alt="image" src="https://user-images.githubusercontent.com/83971386/211191031-a64d4135-22c9-45e2-9873-e437fe050df5.png">

Or check via the AWS Console GUI -

<img width="653" alt="image" src="https://user-images.githubusercontent.com/83971386/211191064-a0a5933d-126a-4c23-8619-a9264ebdb511.png">

#### 2. Verify the Nodes

  kubectl get nodes 
  
<img width="538" alt="image" src="https://user-images.githubusercontent.com/83971386/211192410-9584827a-80d7-458a-abdc-e12c315ec5bb.png">

Or check via the AWS Console 

## Teardown steps

#### 1.	Destroy the deployed AWS Infrastructure 
`terraform destroy --auto-approve`

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 19.5.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Useful Links

* https://github.com/hashicorp/learn-terraform-provision-eks-cluster
* https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks
* https://github.com/terraform-aws-modules/terraform-aws-eks/tree/master/examples/eks_managed_node_group
* https://github.com/hashicorp/terraform-provider-helm/issues/893
