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

variable "region" {
  description = "deployment region"
  type        = string
  default     = "us-east-1"
}