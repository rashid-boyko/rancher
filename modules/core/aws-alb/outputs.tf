output "lb_dns_name" {
  value = aws_lb.load_balancer.dns_name
}

output "lb_target_group_80_arn" {
  value = aws_lb_target_group.target_group_80.arn
}

output "lb_target_group_443_arn" {
  value = aws_lb_target_group.target_group_443.arn
}
