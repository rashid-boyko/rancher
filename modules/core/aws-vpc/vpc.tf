module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name                         = "${var.combined_prefix}-vpc"
  cidr                         = var.vpc_cidr
  azs                          = data.aws_availability_zones.available.names
  public_subnets               = var.vpc_public_subnet_cidrs
  private_subnets              = var.vpc_private_subnet_cidrs_eks
  enable_nat_gateway           = true
  single_nat_gateway           = false
  enable_dns_hostnames         = true
  create_database_subnet_group = false

  public_subnet_tags = {
    "Name"                                         = "${var.combined_prefix}-public-subnet"
    "kubernetes.io/cluster/${var.combined_prefix}" = "shared"
    "kubernetes.io/role/elb"                       = "1"
  }

  private_subnet_tags = {
    "Name"                                            = "${var.combined_prefix}-eks-private-subnet"
    "kubernetes.io/cluster/${var.combined_prefix}"    = "shared"
    "kubernetes.io/role/internal-elb"                 = "1"
    "karpenter.sh/discovery/${var.cluster_name}-node" = var.cluster_name
    "karpenter.sh/discovery"                          = var.cluster_name
  }

  database_subnet_tags = {
    "Name" = "${var.combined_prefix}-db-private-subnet"
  }
}
