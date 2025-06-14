module "bu_cloudtrail_log_bucket" {
   providers = {
    aws = aws.logarchive
  }
  
  source                        = "./module/s3"
  bucket_name                   = var.bucket_name
  enable_versioning             = false
  enable_server_side_encryption = false
  create_kms_key                = false
  create_read_write_policy      = false
  create_read_only_policy       = false
  bucket_key_enabled            = false
  expiration_days               = 365
}



resource "aws_s3_bucket_policy" "vpc_flow_logs_policy" {
  bucket = var.bucket_name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = flatten([
      for account_id in var.source_accounts : [ 
        {
          Sid = "vpc-log-${account_id}"
          Effect = "Allow"
          Principal = {
            Service = "delivery.logs.amazonaws.com"
          }
          Action = "s3:PutObject"
          Resource = "arn:aws:s3:::${var.bucket_name}/AWSLogs/${account_id}/*"
        
          Condition = {
            StringEquals = {
              "aws:SourceAccount" = "${account_id}"
              "s3:x-amz-acl" = "bucket-owner-full-control"
            },
          }
        },
        {
          Sid = "AWSLogDeliveryCheck-${account_id}"
          Effect = "Allow"
          Principal = {
            Service = "delivery.logs.amazonaws.com"
          }
          Action = [
                "s3:GetBucketAcl",
                "s3:ListBucket"
            ]
          Resource = "arn:aws:s3:::${var.bucket_name}"
          Condition = {
            StringEquals = {
              "aws:SourceAccount" = "${account_id}"
            },
          }
        },
      ]
    ])
  })
}



module "bu_vpc_flow_log_us_east_2" {
  source                        = "./modules/vpc_flow_log"
   providers = {aws = aws.us-east-2}
  bucket_name                   = var.bucket_name
  vpc_ids = data.aws_vpcs.vpc_us-east-2.ids
  depends_on = [ aws_s3_bucket_policy.vpc_flow_logs_policy ]
}

module "bu_vpc_flow_log_us_west_2" {
 source                        = "./modules/vpc_flow_log"
 providers = {aws = aws.us-west-2}
  bucket_name                   = var.bucket_name
  vpc_ids = data.aws_vpcs.vpc_us-west-2.ids
  depends_on = [ aws_s3_bucket_policy.vpc_flow_logs_policy ]
}
module "bu_vpc_flow_log_us_west_1" {
  source                        = "./modules/vpc_flow_log"
  providers = {aws = aws.us-west-1 }
  bucket_name                   = var.bucket_name
  vpc_ids = data.aws_vpcs.vpc_us-west-1.ids
  depends_on = [ aws_s3_bucket_policy.vpc_flow_logs_policy ]
}