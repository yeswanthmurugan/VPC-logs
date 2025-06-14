variable "source_accounts" {
  description = "Log source AWS account Id's with their names"
  type        = list(string)
}

variable "bucket_name" {
  type = string
}

variable "vpcs" {
  type = map(object({
    account_id = string
    region     = string
    vpc_id     = string
  }))
}