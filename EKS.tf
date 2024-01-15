resource "aws_eks_cluster" "pkdeva" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.pkdeva.arn
  vpc_config {
    subnet_ids = [
      aws_subnet.pvt-sub-1.id,
      aws_subnet.pvt-sub-2.id,
      aws_subnet.pub-sub-1.id,
      aws_subnet.pub-sub-2.id
    ]
    endpoint_private_access = false
    endpoint_public_access = true
  }

  depends_on = [aws_iam_role_policy_attachment.pkdeva-AmazonEKSClusterPolicy]
}


resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.pkdeva.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.pkdeva-nodes.arn
  

  subnet_ids = [
    aws_subnet.pvt-sub-1.id,
    aws_subnet.pvt-sub-2.id
  ]

  
  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 1
    max_size     = 5
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }


  depends_on = [
    aws_iam_role_policy_attachment.pkdeva-nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.pkdeva-nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.pkdeva-nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}


### security group stuff: 

resource "aws_security_group" "eks_nodes_pkdeva" {
  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
