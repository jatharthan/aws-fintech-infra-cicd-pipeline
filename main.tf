module "networking" {
  source         = "./modules/networking"
  project_prefix = var.project_prefix
  region         = var.region
  vpc_cidr_block = var.vpc_cidr_block
  environment    = var.environment
}