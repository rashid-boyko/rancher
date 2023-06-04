output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_name" {
  value = module.vpc.name
}
output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "vpc_public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "vpc_private_subnet_ids" {
  value = module.vpc.private_subnets
}
output "vpc_database_subnet_ids" {
  value = module.vpc.database_subnets
}

output "vpc_private_subnet_cidrs_eks" {
  value = var.vpc_private_subnet_cidrs_eks
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.private_subnets
}

output "route_table" {
  value = module.vpc.vpc_main_route_table_id
}
