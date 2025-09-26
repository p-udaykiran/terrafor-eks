# Configure AWS provider for the specified region (Asia Pacific - Mumbai)
provider "aws" {
  region = "ap-south-1"
}

# Create a Virtual Private Cloud (VPC) with a CIDR block of 10.0.0.0/16
resource "aws_vpc" "uday_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "uday-vpc"
  }
}

# Create two subnets within the VPC, each in different availability zones
resource "aws_subnet" "uday_subnet" {
  count = 2
  vpc_id                  = aws_vpc.uday_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.uday_vpc.cidr_block, 8, count.index)
  availability_zone       = element(["ap-south-1a", "ap-south-1b"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "uday-subnet-${count.index}"
  }
}

# Create an Internet Gateway and associate it with the VPC
resource "aws_internet_gateway" "uday_igw" {
  vpc_id = aws_vpc.uday_vpc.id

  tags = {
    Name = "uday-igw"
  }
}

# Create a route table and add a default route to the Internet Gateway
resource "aws_route_table" "uday_route_table" {
  vpc_id = aws_vpc.uday_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.uday_igw.id
  }

  tags = {
    Name = "uday-route-table"
  }
}

# Associate the route table with the subnets
resource "aws_route_table_association" "uday_association" {
  count          = 2
  subnet_id      = aws_subnet.uday_subnet[count.index].id
  route_table_id = aws_route_table.uday_route_table.id
}

# Create a security group for EKS cluster with unrestricted egress
resource "aws_security_group" "uday_cluster_sg" {
  vpc_id = aws_vpc.uday_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "uday-cluster-sg"
  }
}

# Create a security group for EKS node group with unrestricted ingress and egress
resource "aws_security_group" "uday_node_sg" {
  vpc_id = aws_vpc.uday_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "uday-node-sg"
  }
}

# Create an EKS cluster with the specified role and VPC configuration
resource "aws_eks_cluster" "uday" {
  name     = "uday-cluster"
  role_arn = aws_iam_role.uday_cluster_role.arn

  vpc_config {
    subnet_ids         = aws_subnet.uday_subnet[*].id
    security_group_ids = [aws_security_group.uday_cluster_sg.id]
  }
}

# Add the Amazon EBS CSI driver to the EKS cluster
resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name    = aws_eks_cluster.uday.name
  addon_name      = "aws-ebs-csi-driver"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

# Create a node group within the EKS cluster with EC2 instances
resource "aws_eks_node_group" "uday" {
  cluster_name    = aws_eks_cluster.uday.name
  node_group_name = "uday-node-group"
  node_role_arn   = aws_iam_role.uday_node_group_role.arn
  subnet_ids      = aws_subnet.uday_subnet[*].id

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t2.medium"]

  remote_access {
    ec2_ssh_key = var.ssh_key_name
    source_security_group_ids = [aws_security_group.uday_node_sg.id]
  }
}

# Create an IAM role for the EKS cluster with the necessary trust policy
resource "aws_iam_role" "uday_cluster_role" {
  name = "uday-cluster-role"

  assume_role_policy = <<EOF
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
EOF
}

# Attach the necessary IAM policy to the EKS cluster role
resource "aws_iam_role_policy_attachment" "uday_cluster_role_policy" {
  role       = aws_iam_role.uday_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Create an IAM role for the EKS node group with the necessary trust policy
resource "aws_iam_role" "uday_node_group_role" {
  name = "uday-node-group-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach policies to the node group IAM role for worker node functionality
resource "aws_iam_role_policy_attachment" "uday_node_group_role_policy" {
  role       = aws_iam_role.uday_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "uday_node_group_cni_policy" {
  role       = aws_iam_role.uday_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "uday_node_group_registry_policy" {
  role       = aws_iam_role.uday_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "uday_node_group_ebs_policy" {
  role       = aws_iam_role.uday_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}
