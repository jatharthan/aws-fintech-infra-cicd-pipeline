module "networking" {
  source         = "./modules/networking"
  project_prefix = var.project_prefix
  region         = var.region
  vpc_cidr_block = local.vpc_cidr_block
  environment    = var.environment
}

# module "eks" {
#   source                 = "./modules/eks"
#   project_prefix = var.project_prefix
#   region         = var.region
#   environment            = var.environment
#   vpc_id                 = module.networking.vpc_id
#   cluster_name           = "pulseagami-eks"
#   private_subnet_ids     = module.networking.private_subnet_ids
#   public_subnet_ids      = module.networking.public_subnet_ids
#   node_security_group_ids = [module.networking.ec2_sg_id]  # EC2 SG from your VPC module
# }
