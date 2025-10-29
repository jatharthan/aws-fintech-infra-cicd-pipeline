variable "project_prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "insp1"
}

variable "company" {
  description = "Comapny name"
  type        = string
  default     = "pulseagami"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type    = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  default = "dev"
  type    = string
}

variable "region" {
  description = "deployment region"
  type        = string
  default     = "us-east-1"
}
