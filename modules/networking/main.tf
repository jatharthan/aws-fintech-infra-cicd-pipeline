terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# -------------------
# Data Sources
# -------------------
data "aws_availability_zones" "available" {}

# -------------------
# VPC
# -------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_prefix}-${var.region}-${var.environment}-vpc"
  }
}

# # -------------------
# # Internet Gateway
# # -------------------
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "${var.project_prefix}-${var.region}-${var.environment}-igw"
#   }
# }

# # -------------------
# # Public Subnets
# # -------------------
# resource "aws_subnet" "public" {
#   count                   = 2
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = cidrsubnet(var.vpc_cidr_block, 4, count.index)
#   map_public_ip_on_launch = true
#   availability_zone       = data.aws_availability_zones.available.names[count.index]
#   tags = {
#     Name = "${var.project_prefix}-${var.region}-${var.environment}-public-${count.index}"
#   }
# }

# # -------------------
# # Private Subnets
# # -------------------
# resource "aws_subnet" "private" {
#   count             = 2
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, count.index + 2)
#   availability_zone = data.aws_availability_zones.available.names[count.index]
#   tags = {
#     Name = "${var.project_prefix}-${var.region}-${var.environment}-private-${count.index}"
#   }
# }

# # -------------------
# # Public Route Table
# # -------------------
# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "${var.project_prefix}-${var.region}-${var.environment}-rt-public"
#   }
# }

# resource "aws_route" "default_route" {
#   route_table_id         = aws_route_table.public.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }

# resource "aws_route_table_association" "public" {
#   count          = 2
#   subnet_id      = aws_subnet.public[count.index].id
#   route_table_id = aws_route_table.public.id
# }

# # -------------------
# # NAT Gateway for Private Subnets
# # -------------------
# resource "aws_eip" "nat" {
#   tags = {
#     Name = "${var.project_prefix}-${var.region}-${var.environment}-nat-eip"
#   }
# }

# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public[0].id
#   depends_on    = [aws_internet_gateway.igw]
#   tags = {
#     Name = "${var.project_prefix}-${var.region}-${var.environment}-nat"
#   }
# }

# # -------------------
# # Private Route Table
# # -------------------

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "${var.project_prefix}-${var.region}-${var.environment}-rt-private"
#   }
# }

# resource "aws_route" "private_default_route" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.nat.id
# }

# resource "aws_route_table_association" "private" {
#   count          = 2
#   subnet_id      = aws_subnet.private[count.index].id
#   route_table_id = aws_route_table.private.id
# }

# # -------------------
# # Security Groups
# # -------------------
# # EC2 SG
# resource "aws_security_group" "ec2_sg" {
#   name        = "${var.project_prefix}-${var.region}-${var.environment}-ec2-sg"
#   description = "Allow SSH, HTTP, HTTPS, and app port 3000"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTPS"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "App (Port 3000)"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Allow all outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${var.project_prefix}-${var.region}-${var.environment}-ec2-sg"
#   }
# }

# # ALB SG
# resource "aws_security_group" "alb_sg" {
#   name        = "${var.project_prefix}-${var.region}-${var.environment}-alb-sg"
#   description = "Allow HTTP and HTTPS traffic to the public load balancer"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description = "Allow HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "Allow HTTPS"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Allow all outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${var.project_prefix}-${var.region}-${var.environment}-alb-sg"
#   }
# }
