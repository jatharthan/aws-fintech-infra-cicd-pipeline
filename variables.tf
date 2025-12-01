variable "company" {
  description = "Comapny name"
  type        = string
  default     = "pulseagami"
}

variable "project_prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "insp1"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type    = string
}

variable "region" {
  description = "deployment region"
  type        = string
  default     = "us-east-1"
}
