resource "aws_lb" "load_balancer" {
  name               = "${var.combined_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.vpc_public_subnet_ids

  security_groups = [
    aws_security_group.lb_sg.id,
    var.cluster_primary_security_group_id
  ]

  tags = merge(
    var.common_tags,
    { "kubernetes.io/cluster/${var.cluster_id}" = "owned" }
  )
}
