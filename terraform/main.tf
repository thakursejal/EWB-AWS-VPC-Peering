
# AWS VPC Peering Student Project
# Infrastructure configuration using Terraform

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# --------------------------------------------------
# VPC A
# --------------------------------------------------

resource "aws_vpc" "vpc_a" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "ewb-vpc-a"
    Project = "EWB-VPC-Peering"
  }
}

# --------------------------------------------------
# VPC B
# --------------------------------------------------

resource "aws_vpc" "vpc_b" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "ewb-vpc-b"
    Project = "EWB-VPC-Peering"
  }
}

# --------------------------------------------------
# VPC A Subnets
# --------------------------------------------------

resource "aws_subnet" "a_public" {
  vpc_id                  = aws_vpc.vpc_a.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "ewb-a-public"
  }
}

resource "aws_subnet" "a_private" {
  vpc_id     = aws_vpc.vpc_a.id
  cidr_block = "10.10.2.0/24"

  tags = {
    Name = "ewb-a-private"
  }
}

# --------------------------------------------------
# VPC B Subnet
# --------------------------------------------------

resource "aws_subnet" "b_private" {
  vpc_id     = aws_vpc.vpc_b.id
  cidr_block = "10.20.1.0/24"

  tags = {
    Name = "ewb-b-private"
  }
}

# --------------------------------------------------
# Internet Gateway
# --------------------------------------------------

resource "aws_internet_gateway" "igw_a" {
  vpc_id = aws_vpc.vpc_a.id

  tags = {
    Name = "ewb-igw-a"
  }
}

# --------------------------------------------------
# VPC Peering Connection
# --------------------------------------------------

resource "aws_vpc_peering_connection" "a_b" {
  vpc_id      = aws_vpc.vpc_a.id
  peer_vpc_id = aws_vpc.vpc_b.id
  auto_accept = true

  tags = {
    Name = "ewb-a-b-peer"
  }
}

# --------------------------------------------------
# Public Route Table for VPC A
# --------------------------------------------------

resource "aws_route_table" "a_public" {
  vpc_id = aws_vpc.vpc_a.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_a.id
  }

  route {
    cidr_block                = "10.20.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.a_b.id
  }

  tags = {
    Name = "ewb-rt-a-public"
  }
}

# --------------------------------------------------
# Private Route Table for VPC A
# --------------------------------------------------

resource "aws_route_table" "a_private" {
  vpc_id = aws_vpc.vpc_a.id

  route {
    cidr_block                = "10.20.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.a_b.id
  }

  tags = {
    Name = "ewb-rt-a-private"
  }
}

# --------------------------------------------------
# Private Route Table for VPC B
# --------------------------------------------------

resource "aws_route_table" "b_private" {
  vpc_id = aws_vpc.vpc_b.id

  route {
    cidr_block                = "10.10.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.a_b.id
  }

  tags = {
    Name = "ewb-rt-b-private"
  }
}

# --------------------------------------------------
# Route Table Associations
# --------------------------------------------------

resource "aws_route_table_association" "a_public" {
  subnet_id      = aws_subnet.a_public.id
  route_table_id = aws_route_table.a_public.id
}

resource "aws_route_table_association" "a_private" {
  subnet_id      = aws_subnet.a_private.id
  route_table_id = aws_route_table.a_private.id
}

resource "aws_route_table_association" "b_private" {
  subnet_id      = aws_subnet.b_private.id
  route_table_id = aws_route_table.b_private.id
}
