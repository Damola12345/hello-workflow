############################################################
# Output for VPC                                           #
############################################################

# Region
output "region" {
  value = var.region
}

# VPC ID
output "vpc-id" {
  value = aws_vpc.vpc.id
}

# Internet Gateway
output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}

# Public Subnet 1 ID
output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

# Public Subnet 2 ID
output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

# Private Subnet 1 ID
output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

# Private Subnet 2 ID
output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}
