variable "aws_region" {}
variable "name_prefix" {}
variable "environment" {}
variable "project" {}

variable "vpc_cidr_block" {}
variable "vpc_public_subnet_cidrs" {}
variable "vpc_private_subnet_cidrs_eks" {}
variable "vpc_flow_logs_enabled" {}

variable "s3_logs_bucket_name" {}
variable "s3_logs_bucket_enable_destroy" {}
variable "traffic_type_cloudwatch" {}
variable "traffic_type_s3" {}
