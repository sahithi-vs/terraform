resource "aws_eks_cluster" "cluster" {
  name     = var.cluster-name
  role_arn = aws_iam_role.cluster-role.arn

  vpc_config {
    security_group_ids = [aws_security_group.cluster-group.id]
    subnet_ids         = module.vpc.public_subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster-AmazonEKSServicePolicy,
  ]
}

