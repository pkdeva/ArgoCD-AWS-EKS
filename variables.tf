
variable "eks_cluster_name" {
  description = "cluster-pkdeva"
  default     = "argocd-cluster"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}
