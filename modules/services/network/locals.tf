locals {
  vpc_id          = module.aws_vpc.vpc_id
  combined_prefix = "${var.environment}-${var.name_prefix}"
  cluster_name    = "${var.environment}-${var.project}-cluster"
  bucket          = "${var.project}-${var.s3_logs_bucket_name}-${var.environment}-${random_string.random_string_suffix.result}"

  global_tags = tomap({
    "Environment" = var.environment,
    "Created-By"  = "Terraform"
  })
}
