variable "combined_prefix" {}
variable "vpc_id" {}
variable "vpc_public_subnet_ids" {}

variable "cognito_user_pool_arn" {}
variable "cognito_user_pool_client_id" {}
variable "cognito_user_pool_domain" {}

variable "cluster_id" {}
variable "cluster_primary_security_group_id" {}

variable "public_urls" {}
variable "public_zone_id" {}

variable "custom_endpoint_certificate_arn" {}
variable "endpoint_route53_records" {}
variable "common_tags" {}

variable "auth_required" {
  default = true
}
