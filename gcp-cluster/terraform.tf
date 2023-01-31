# Terraform backend configuration

terraform {
  backend "remote" {
    organization = "xxxxxxxxxxx"

    workspaces {
      name = "compute-prod-us-central"
    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.51"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "~> 1.24"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
  }
}

