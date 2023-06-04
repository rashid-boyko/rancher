resource "aws_lb_target_group" "target_group_80" {
  name     = "${var.combined_prefix}-tg-80"
  port     = 31250
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "target_group_443" {
  name     = "${var.combined_prefix}-tg-443"
  port     = 32664
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
}