# Input variables

# Node image
variable "ami_image" {
  type = string
}

# Node disk size in GB
variable "disk_size" {
  type = number
}

# Node type
variable "type" {
  type = string
}

# Kubernetes version
variable "k8s_version" {
  type = string
}

# Docker version
variable "docker_url" {
  type = string
}

# Number of nodes
variable "num_nodes" {
  type = number
}

# Monitoring chart
variable "mon_chart" {
  type = string
}

# Logging chart
variable "log_chart" {
  type = string
}

# Longhorn chart
variable "longhorn_chart" {
  type = string
}

# Bitnami URL
variable "bitnami_url" {
  type = string
}

# EC2 Region
variable "aws_region" {
  type = string
}

# EC2 Availability Zone
variable "aws_zone" {
  default = "a"
}

# EC2 Subnet
variable "ec2_subnet" {
  type = string
}

# EC2 VPC
variable "ec2_vpc" {
  type = string
}

# EC2 Security Group
variable "ec2_sec_group" {
  type = string
}
# Hack: Time to wait for Kubernetes to deploy
variable "delay_sec" {
  type = number
}

variable "rancher_url" {
  type = string
}

variable "rancher_token" {
  type = string
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "prom_remote_user" {
  type = string
}

variable "prom_remote_pass" {
  type = string
}
