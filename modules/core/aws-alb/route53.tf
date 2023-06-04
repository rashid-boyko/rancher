resource "aws_route53_record" "route53_records" {
  for_each = var.endpoint_route53_records

  zone_id         = var.public_zone_id
  name            = each.value
  type            = "CNAME"
  ttl             = "300"
  records         = [aws_lb.load_balancer.dns_name]
  allow_overwrite = true
}
