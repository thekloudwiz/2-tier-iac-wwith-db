# Fetch Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Fetch VPC ID from SSM Parameter Store
data "aws_ssm_parameter" "vpc_id" {
  name = "/${local.name_prefix}/vpc_id"

  depends_on = [aws_ssm_parameter.vpc_id]
}

# Fetch Subnet IDS from SSM Parameter Store
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${local.name_prefix}/public_subnet_ids"

  depends_on = [aws_ssm_parameter.public_subnet_ids]
}

# Fetch App Private Subnet IDs from SSM Parameter Store
data "aws_ssm_parameter" "app_private_subnet_ids" {
  name = "/${local.name_prefix}/app_private_subnet_ids"

  depends_on = [aws_ssm_parameter.app_private_subnet_ids]
}

# Fetch DB Private Subnet IDs from SSM Parameter Store
data "aws_ssm_parameter" "db_private_subnet_ids" {
  name = "/${local.name_prefix}/db_private_subnet_ids"

  depends_on = [aws_ssm_parameter.db_private_subnet_ids]
}

# Fetch Internet Gateway ID from SSM Parameter Store
data "aws_ssm_parameter" "igw_id" {
  name = "/${local.name_prefix}/igw_id"

  depends_on = [aws_ssm_parameter.igw_id]
}

# Fetch NAT Gateway ID from SSM Parameter Store
data "aws_ssm_parameter" "nat_ids" {
  name = "/${local.name_prefix}/nat_ids"

  depends_on = [aws_ssm_parameter.nat_ids]
}