# ArgoCD-AWS-EKS

Deploying ArgoCD on AWS EKS cluster using Terraform.


> About: Before we get on to install the project, let's dig into the `terraform` block and find out what's actually going on:

- `EKS.tf` : In this module, we have defined to create AWS EKS Cluster with EKS NodeGroup and SecurityGroup.
- `IAM-role.tf` : here, we're creating the IAM role and also attaching required policies, such as AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy, and AmazonEC2ContainerRegistry.
  - detailed IAM documentation can be found [here](https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html)
- `NAT-gateway.tf` : in this module, we're creating ElasticIP (EIP - a static IPv4 address for our Instance) and also "AWS NAT Gateway" in the Public Subnet to let our instances communicate to the Internet.

- `subnet.tf` : we're creating total 4 subnets (2 public and 2 private) in two different Availability Zones.
- `RTB.tf` :  here in this module, we have routing table for our VPC with it's association between route table, subnet and the internet gateway. 
- `variables.tf` : here we've some variables stored which we gonna map in different module.
- `VPC.tf` : here we've VPC creating for ArgoCD and Internet Gateway.
- `provider.tf` : here we've nothing but just declaring our region and provider, "AWS" to let terraform interact with the available resources of AWS.


<h2> Requisites: </h2>

- [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform)
- [awscli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#before-you-begin)
- [helm](https://helm.sh/docs/intro/install/)
