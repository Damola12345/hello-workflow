# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "vpc" {
  # the CIDR block for VPC
  cidr_block = var.vpc-cidr

  # Makes instances shared on the host.
  instance_tenancy = "default"

  # Required for EKS. Enable/disable DNS support & hostnames in the VPC
  enable_dns_support   = true
  enable_dns_hostnames = true

  # Enable/disable classiclink/classiclink DNS support for vpc
  # enable_classiclink             = false
  # enable_classiclink_dns_support = false

  assign_generated_ipv6_cidr_block = false

  # A map of tags assigned to the resource. 
  tags = {
    Name = "EKS-vpc"
  }
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "EKS-igw"
  }
}

# Data source to get all availability_zone in region
data "aws_availability_zones" "availability_zones" {}

# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_1az_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    "Name"                      = "Public Subnet 1azA"
    "kubernetes.io/role/elb"    = "1"
    "kubernetes.io/cluster/Eks" = "owned"
  }
}

# Create Public Subnet 2
# terraform aws create subnet
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_2az_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    "Name"                      = "Public Subnet 2azB"
    "kubernetes.io/role/elb"    = "1"
    "kubernetes.io/cluster/Eks" = "owned"
  }
}

# Create Private Subnet 1
# terraform aws create subnet
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_1az_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    "Name"                      = "Private Subnet 1"
    "kubernetes.io/role/elb"    = "1"
    "kubernetes.io/cluster/Eks" = "shared"
  }
}

# Create Private Subnet 2
# terraform aws create subnet
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_2az_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    "Name"                      = "Private Subnet 2"
    "kubernetes.io/role/elb"    = "1"
    "kubernetes.io/cluster/Eks" = "shared"
  }
}