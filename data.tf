# data.tf
data "aws_ssm_parameter" "vpc_cidr_block" {
#   name = "/pulseagami/insp1/dev/vpc_cidr_block"
  name = "/${var.company}/${var.project_prefix}/${var.environment}/vpc_cidr_block"
}

# locals.tf
locals {
  vpc_cidr_block = data.aws_ssm_parameter.vpc_cidr_block.value
}