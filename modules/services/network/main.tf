module "aws_vpc" {
  source = "../../core/aws-vpc"

  vpc_cidr                     = var.vpc_cidr_block
  vpc_public_subnet_cidrs      = var.vpc_public_subnet_cidrs
  vpc_private_subnet_cidrs_eks = var.vpc_private_subnet_cidrs_eks
  combined_prefix              = local.combined_prefix
  cluster_name                 = local.cluster_name
}

module "aws_vpc_flow_logs" {
  source = "../../core/aws-vpc-flow-logs"
  count  = var.vpc_flow_logs_enabled ? 1 : 0

  project                 = var.project
  environment             = var.environment
  vpc_id                  = module.aws_vpc.vpc_id
  traffic_type_s3         = var.traffic_type_s3
  traffic_type_cloudwatch = var.traffic_type_cloudwatch
}

module "aws_s3_bucket_for_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"
  count   = var.vpc_flow_logs_enabled ? 1 : 0

  bucket        = local.bucket
  acl           = "log-delivery-write"
  force_destroy = var.s3_logs_bucket_enable_destroy

  attach_elb_log_delivery_policy = true
  attach_lb_log_delivery_policy  = true

  tags = local.global_tags
}

resource "random_string" "random_string_suffix" {
  length  = 16
  special = false
  upper   = false
}
