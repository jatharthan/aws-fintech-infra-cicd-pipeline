module "networking" {
  source         = "./modules/networking"
  project_prefix = var.project_prefix
  region         = var.region
  vpc_cidr_block = local.vpc_cidr_block
  environment    = var.environment
}