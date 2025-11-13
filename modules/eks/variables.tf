variable "region" {
  type = string
}

variable "project_prefix" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EKS will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for EKS worker nodes"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB / load balancers"
  type        = list(string)
}

variable "eks_version" {
  description = "EKS cluster Kubernetes version"
  type        = string
  default     = "1.34"
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Max number of worker nodes"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Min number of worker nodes"
  type        = number
  default     = 1
}

variable "node_security_group_ids" {
  description = "List of security group IDs for worker nodes"
  type        = list(string)
}