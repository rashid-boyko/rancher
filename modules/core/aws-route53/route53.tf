resource "aws_route53_record" "route53_record" {
  zone_id = var.aws_route_53_zone_id
  name    = "${var.environment}-pbp-opensearch"
  type    = "CNAME"
  ttl     = "300"
  records = [var.opensearch_domain_name]
}
