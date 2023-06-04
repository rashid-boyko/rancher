resource "aws_lb_listener" "eks_listener_443_no_auth" {
  count             = var.auth_required ? 0 : 0
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.custom_endpoint_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_80.arn
  }
}

resource "aws_lb_listener" "eks_listener_443_auth" {
  count             = var.auth_required ? 1 : 0
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.custom_endpoint_certificate_arn

  default_action {
    type = "authenticate-cognito"

    authenticate_cognito {
      user_pool_arn       = var.cognito_user_pool_arn
      user_pool_client_id = var.cognito_user_pool_client_id
      user_pool_domain    = var.cognito_user_pool_domain
    }
  }

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_80.arn
  }
}

resource "aws_lb_listener_rule" "host_based_routing" {
  count        = var.auth_required ? 1 : 0
  listener_arn = aws_lb_listener.eks_listener_443_auth[count.index].arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_80.arn
  }

  condition {
    host_header {
      values = var.public_urls
    }
  }
}
