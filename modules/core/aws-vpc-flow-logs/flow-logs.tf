resource "aws_flow_log" "vpc_flow_logs_cloudwatch" {
  iam_role_arn    = aws_iam_role.aws_iam_role_vpc_flow_logs.arn
  log_destination = aws_cloudwatch_log_group.cloudwatch_log_group_vpc_flow_logs.arn
  traffic_type    = var.traffic_type_cloudwatch
  vpc_id          = var.vpc_id
}

resource "aws_flow_log" "vpc_flow_logs_s3" {
  log_destination      = aws_s3_bucket.vpc_flow_logs_bucket.arn
  log_destination_type = "s3"
  traffic_type         = var.traffic_type_s3
  vpc_id               = var.vpc_id

  destination_options {
    file_format        = "parquet"
    per_hour_partition = true
  }
}

resource "aws_s3_bucket" "vpc_flow_logs_bucket" {
  bucket        = "${var.project}-vpc-flow-logs-bucket-${var.environment}"
  force_destroy = true
}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group_vpc_flow_logs" {
  name = "${var.project}-cloudwatch-log-group-vpc-flow-logs-${var.environment}"
}

