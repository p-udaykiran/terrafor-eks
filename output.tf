output "cluster_id" {
  value = aws_eks_cluster.uday.id
}

output "node_group_id" {
  value = aws_eks_node_group.uday.id
}

output "vpc_id" {
  value = aws_vpc.uday_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.uday_subnet[*].id
}
