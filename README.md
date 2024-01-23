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
- `provider.tf` : here we've nothing but just declaring our region and provider, "AWS" to let Terraform interact with the available resources of AWS.

<h5> Architecture Diagram of our AWS infra: </h5>

![ArgoCD-AWS-EKS-Deployment-Architecture-Image](https://github.com/pkdeva/ArgoCD-AWS-EKS/assets/83779939/ed3b6104-17a7-46c4-b876-3979ff9071c5)

-----------------------------------------
<h2> Requisites: </h2>

- [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform)
- [awscli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#before-you-begin)
- [helm](https://helm.sh/docs/intro/install/) - Kubernetes Package Manager


-----------------------------------------
<h2> Setup: </h2> 
<h4>deploying EKS cluster on AWS: </h4>

- clone this repo into your machine and initiate the Terraform using `terraform init`
- authenticate into your aws console using `aws configure`
- apply the terraform modules using `terraform apply`. it will show the preview of resources which are gonna create. confirm to create.
- 
<h4> Installing and configuring ArgoCD: </h4>

- run `kubectl create namespace argocd` to isolate resources within our cluster.
- check and list all resources with `kubectl get all -n argocd`
- install ArgoCD: `helm repo add argo https://argoproj.github.io/argo-helm` 
- `helm install argocd argo/argo-cd -n argocd`
- to expose the ArgoCD service to access the web UI: `kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'`
- to obtain the external IP: `kubectl get svc argocd-server -n argocd -w`. now use that external IP to access the ArgoCD UI.

<h6> Get the ArgoCD initial admin password: </h6>

- for Linux: `kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d`
- for Windows Powershell: `[Text.Encoding]::Utf8.GetString([Convert]::FromBase64String((kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}")))`
  


