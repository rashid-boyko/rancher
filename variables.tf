# Network variables

variable "environment" {
  type = string
  default = "dev"
}

variable "project" {
  type = string
  default = "rancher"
}

variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_public_subnet_cidrs" {
  type = list(any)
  default = ["10.0.1.0/24"]
}

variable "vpc_private_subnet_cidrs_eks" {
  type = list(any)
  default = ["10.0.2.0/24"]
}

variable "vpc_flow_logs_enabled" {
  type    = bool
  default = false
}

variable "traffic_type_cloudwatch" {
  type    = string
  default = "ALL"
}

variable "traffic_type_s3" {
  type    = string
  default = "ALL"
}

variable "s3_logs_bucket_name" {
  type    = string
  default = "vpc-logs"
}

variable "s3_logs_bucket_enable_destroy" {
  type    = string
  default = true
}

# Input variables

# Node image
variable "ami_image" {
  default = "ami-02584c1c9d05efa69"
}

# Node disk size in GB
variable "disk_size" {
  default = 128
}

# Node type
variable "type" {
  default = "m5a.xlarge"
}

# Kubernetes version
variable "k8s_version" {
  default = "v1.25.9-rancher2-1"
}

# Docker version
variable "docker_url" {
  default = "https://releases.rancher.com/install-docker/20.10.sh"
}

# Number of nodes
variable "num_nodes" {
  default = 3
}

# Monitoring chart
variable "mon_chart" {
  default = "102.0.0"
}

# Logging chart
variable "log_chart" {
  default = "102.0.0"
}

# Longhorn chart
variable "longhorn_chart" {
  default = "102.2.0"
}

# Bitnami URL
variable "bitnami_url" {
  default = "https://charts.bitnami.com/bitnami"
}

# aws Region
variable "aws_region" {
  default = "eu-west-1"
}

# aws Availability Zone
variable "aws_zone" {
  default = "a"
}

# aws Security Group
variable "ec2_sec_group" {
  default = "rancher-nodes"
}

# Hack: Time to wait for Kubernetes to deploy
variable "delay_sec" {
  default = 960
}

variable "rancher_url" {}

variable "rancher_token" {}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "prom_remote_user" {}

variable "prom_remote_pass" {}

