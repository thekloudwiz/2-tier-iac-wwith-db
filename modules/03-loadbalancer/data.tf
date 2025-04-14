# Fetch AVAILABILITY ZONES
data "aws_availability_zones" "available" {
  state = "available"
}

# Fetch VPC ID from SSM Parameter Store
data "aws_ssm_parameter" "vpc_id" {
  name = "/${local.name_prefix}/vpc_id"
}

# Fetch Subnet IDS from SSM Parameter Store
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${local.name_prefix}/public_subnet_ids"
}

# Fetch Private Subnet IDs from SSM Parameter Store
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${local.name_prefix}/private_subnet_ids"
}

# Fetch Security ALB Security Group IDs from SSM Parameter Store
data "aws_ssm_parameter" "alb_sg_id" {
  name = "/${local.name_prefix}/alb_sg_id"
}

# Fetch Log Bucket From SSM Parameter Store
data "aws_s3_bucket" "alb_logs" {
  bucket = "${local.name_prefix}-alb-logs"
}

# Get ACM Certificate
data "aws_acm_certificate" "acm_cert" {
  domain   = var.wildcard_domain_name
  statuses = ["ISSUED"]
  types    = ["AMAZON_ISSUED"]
}

# Get IAM Certificate
data "aws_iam_server_certificate" "iam_cert" {
  name = var.iam_cert_name
}