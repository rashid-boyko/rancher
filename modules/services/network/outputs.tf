output "vpc_id" {
  value = module.aws_vpc.vpc_id
}
output "vpc_name" {
  value = module.aws_vpc.vpc_name
}
output "vpc_cidr_block" {
  value = module.aws_vpc.vpc_cidr_block
}
output "private_route_table_ids" {
  value = module.aws_vpc.private_route_table_ids
}
output "vpc_public_subnet_ids" {
  value = module.aws_vpc.vpc_public_subnet_ids
}
output "vpc_private_subnet_ids" {
  value = module.aws_vpc.vpc_private_subnet_ids
}
output "vpc_database_subnet_ids" {
  value = module.aws_vpc.vpc_database_subnet_ids
}
output "vpc_private_subnet_cidrs_eks" {
  value = var.vpc_private_subnet_cidrs_eks
}
output "vpc_public_subnet_cidrs_eks" {
  value = var.vpc_public_subnet_cidrs
}
