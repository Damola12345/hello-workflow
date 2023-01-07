# VPC Variables
variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
  type        = string
}

variable "vpc-cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnet_1az_cidr" {
  default     = "10.0.0.0/24"
  description = "Public Subnet 1 CIDR Block"
  type        = string
}

variable "public_subnet_2az_cidr" {
  default     = "10.0.1.0/24"
  description = "Public Subnet 2 CIDR Block"
  type        = string
}

variable "private_subnet_1az_cidr" {
  default     = "10.0.2.0/24"
  description = "Private Subnet 1 CIDR Block"
  type        = string
}

variable "private_subnet_2az_cidr" {
  default     = "10.0.3.0/24"
  description = "Private Subnet 2 CIDR Block"
  type        = string
}
