module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "VPC-for-ArgoCD"
  cidr   = var.vpc_cidr
}

resource "aws_internet_gateway" "ourInternalGateway" {
  vpc_id = module.vpc.vpc_id

}