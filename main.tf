module "rancher" {
  source = "./modules/services/rancher"

  type        = var.type
  ami_image   = var.ami_image
  disk_size   = var.disk_size
  k8s_version = var.k8s_version
  num_nodes   = var.num_nodes

  mon_chart        = var.mon_chart
  log_chart        = var.log_chart
  longhorn_chart   = var.longhorn_chart
  delay_sec        = var.delay_sec
  prom_remote_pass = var.prom_remote_pass
  prom_remote_user = var.prom_remote_user

  aws_region     = var.aws_region
  aws_zone       = var.aws_zone
  ec2_vpc        = module.network.vpc_id
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  ec2_subnet     = module.network.vpc_private_subnet_ids
  ec2_sec_group  = var.ec2_sec_group

  docker_url    = var.docker_url
  bitnami_url   = var.bitnami_url
  rancher_url   = var.rancher_url
  rancher_token = var.rancher_token
}

module "network" {
  source = "./modules/services/network"

  project     = var.project
  aws_region  = var.aws_region
  environment = var.environment
  name_prefix = local.name_prefix

  vpc_cidr_block               = var.vpc_cidr_block
  vpc_flow_logs_enabled        = var.vpc_flow_logs_enabled
  vpc_public_subnet_cidrs      = var.vpc_public_subnet_cidrs
  vpc_private_subnet_cidrs_eks = var.vpc_private_subnet_cidrs_eks

  traffic_type_s3               = var.traffic_type_s3
  traffic_type_cloudwatch       = var.traffic_type_cloudwatch
  s3_logs_bucket_name           = var.s3_logs_bucket_name
  s3_logs_bucket_enable_destroy = var.s3_logs_bucket_enable_destroy
}
