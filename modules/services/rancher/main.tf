# Terraform resources 

# Random ID
resource "random_id" "instance_id" {
  byte_length = 3
}

# Rancher cloud credentials
resource "rancher2_cloud_credential" "credential_ec2" {
  name = "EC2 Credentials"
  amazonec2_credential_config {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }
}

# Rancher node template
resource "rancher2_node_template" "template_ec2" {
  name                = "EC2 Node Template"
  cloud_credential_id = rancher2_cloud_credential.credential_ec2.id
  engine_install_url  = var.docker_url
  amazonec2_config {
    ami                  = var.ami_image
    region               = var.aws_region
    security_group       = [var.ec2_sec_group]
    subnet_id            = var.ec2_subnet
    vpc_id               = var.ec2_vpc
    zone                 = var.aws_zone
    root_size            = var.disk_size
    instance_type        = var.type
    iam_instance_profile = "rancher-combined-control-worker"
    tags                 = "kubernetes.io/cluster/rancher,owned"
  }

  depends_on = [rancher2_cloud_credential.credential_ec2]
}

# Rancher cluster
resource "rancher2_cluster" "cluster_ec2" {
  name        = "ec2_${random_id.instance_id.hex}"
  description = "Terraform"

  rke_config {
    kubernetes_version = var.k8s_version
    cloud_provider {
      name = "aws"
      aws_cloud_provider {
        global {
          kubernetes_cluster_tag = "rancher"
        }
      }
    }
    ignore_docker_version = false
    network {
      plugin = "flannel"
    }
    services {
      etcd {
        backup_config {
          enabled = false
        }
      }
      kubelet {
        extra_args = {
          max_pods = 70
        }
      }
    }
  }

  depends_on = [rancher2_node_template.template_ec2]
}

# Rancher node pool
resource "rancher2_node_pool" "nodepool_ec2" {
  cluster_id       = rancher2_cluster.cluster_ec2.id
  name             = "nodepool"
  hostname_prefix  = "rke-${random_id.instance_id.hex}-"
  node_template_id = rancher2_node_template.template_ec2.id
  quantity         = var.num_nodes
  control_plane    = true
  etcd             = true
  worker           = true

  depends_on = [rancher2_node_template.template_ec2]
}

# Delay hack
resource "null_resource" "before" {
  depends_on = [rancher2_cluster.cluster_ec2, rancher2_node_pool.nodepool_ec2]
}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep ${var.delay_sec}"
  }

  triggers = {
    "before" = "null_resource.before.id"
  }
}

# Kubeconfig file
resource "local_file" "kubeconfig" {
  filename        = "${path.module}/.kube/config"
  content         = rancher2_cluster.cluster_ec2.kube_config
  file_permission = "0600"

  depends_on = [null_resource.delay]
}

# Cluster logging
resource "rancher2_app_v2" "syslog_ec2" {
  lifecycle {
    ignore_changes = all
  }
  cluster_id    = rancher2_cluster.cluster_ec2.id
  name          = "rancher-logging"
  namespace     = "cattle-logging-system"
  project_id    = data.rancher2_project.system.id
  repo_name     = "rancher-charts"
  chart_name    = "rancher-logging"
  chart_version = var.log_chart
  values        = templatefile("${path.module}/files/values-logging.yaml", {})

  depends_on = [local_file.kubeconfig, rancher2_cluster.cluster_ec2, rancher2_node_pool.nodepool_ec2]
}

# Longhorn
resource "rancher2_app_v2" "longhorn_ec2" {
  cluster_id    = rancher2_cluster.cluster_ec2.id
  name          = "longhorn"
  namespace     = "longhorn-system"
  project_id    = data.rancher2_project.system.id
  repo_name     = "rancher-charts"
  chart_name    = "longhorn"
  chart_version = var.longhorn_chart
  values        = templatefile("${path.module}/files/values-longhorn.yaml", {})

  lifecycle {
    ignore_changes = all
  }

  depends_on = [rancher2_app_v2.syslog_ec2, rancher2_cluster.cluster_ec2, rancher2_node_pool.nodepool_ec2]
}

# Monitoring namespace
resource "rancher2_namespace" "promns_ec2" {
  name        = "cattle-monitoring-system"
  project_id  = data.rancher2_project.system.id
  description = "Terraform"

  lifecycle {
    ignore_changes = all
  }

  depends_on = [rancher2_app_v2.longhorn_ec2, rancher2_cluster.cluster_ec2, rancher2_node_pool.nodepool_ec2]
}

# Prometheus secret
resource "rancher2_secret_v2" "promsecret_ec2" {
  cluster_id = rancher2_cluster.cluster_ec2.id
  name       = "remote-writer"
  namespace  = "cattle-monitoring-system"
  type       = "kubernetes.io/basic-auth"
  data = {
    username = var.prom_remote_user
    password = var.prom_remote_pass
  }

  lifecycle {
    ignore_changes = all
  }

  depends_on = [rancher2_namespace.promns_ec2, rancher2_cluster.cluster_ec2, rancher2_node_pool.nodepool_ec2]
}

# Cluster monitoring
resource "rancher2_app_v2" "monitor_ec2" {
  cluster_id    = rancher2_cluster.cluster_ec2.id
  name          = "rancher-monitoring"
  namespace     = "cattle-monitoring-system"
  project_id    = data.rancher2_project.system.id
  repo_name     = "rancher-charts"
  chart_name    = "rancher-monitoring"
  chart_version = var.mon_chart
  values        = templatefile("${path.module}/files/values.yaml", {})

  lifecycle {
    ignore_changes = all
  }

  depends_on = [rancher2_secret_v2.promsecret_ec2, rancher2_cluster.cluster_ec2, rancher2_node_pool.nodepool_ec2]
}

# Bitnami Catalog
resource "rancher2_catalog_v2" "bitnami" {
  cluster_id = rancher2_cluster.cluster_ec2.id
  name       = "bitnami"
  url        = var.bitnami_url

  lifecycle {
    ignore_changes = all
  }

  depends_on = [rancher2_secret_v2.promsecret_ec2, rancher2_cluster.cluster_ec2, rancher2_node_pool.nodepool_ec2]
}

