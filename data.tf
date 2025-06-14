data "aws_vpcs" "vpc_us-east-2" {
 provider = aws.us-east-2
}
data "aws_vpcs" "vpc_us-west-2" {
  provider = aws.us-west-2
}
data "aws_vpcs" "vpc_us-west-1" {
  provider = aws.us-west-1
}