variable "bucket_name" {
  description = "Name of the S3 bucket for VPC Flow Logs"
  type        = string
  
}
variable "vpc_ids" {
  type = list(string)
}
