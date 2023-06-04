# Terraform backend configuration
terraform {
  backend "s3" {
    bucket         = "eks-project-deployment-template-terraform-state"
    region         = "eu-west-1"
    key            = "rancher/ec2-cluster/terraform.state"
    acl            = "bucket-owner-full-control"
    dynamodb_table = "ekspdt-terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}
