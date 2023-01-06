
resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster"

  # the role that EKS use to create AWS resources for k8s clusters
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSClusterPolicy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # The role the policy should be applied to
  role = aws_iam_role.eks_cluster.name
}

resource "aws_eks_cluster" "Eks" {
  # name of the cluster
  name = "Eks"

  role_arn = aws_iam_role.eks_cluster.arn

  version = "1.24"

  vpc_config {
    # indicate whether or not the amazon EKS private API server endpoint is enabled
    endpoint_private_access = false

    # indicate whether or not the amazon EKS public API server endpoint is enabled
    endpoint_public_access = true

    # must be in at least 2 diff AZ
    subnet_ids = [
      aws_subnet.private_subnet_1.id,
      aws_subnet.private_subnet_2.id,
      aws_subnet.public_subnet_1.id,
      aws_subnet.public_subnet_2.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.AmazonEKSClusterPolicy]
}
