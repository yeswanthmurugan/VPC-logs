


resource "aws_flow_log" "vpc_flow_log" {
   for_each = toset(var.vpc_ids)
  log_destination      = "arn:aws:s3:::${var.bucket_name}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = each.value
}