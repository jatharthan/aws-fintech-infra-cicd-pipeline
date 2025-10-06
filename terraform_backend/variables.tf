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

variable "provider_name" {
  description = "provider"
  type        = string
  default     = "us-east-1"
}

# variable "environment" {
#   description = "Environment"
#   type        = string
#   default     = "dev"
# }