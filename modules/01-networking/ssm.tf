# Store VPC and Subnet IDs in SSM

# Store VPC ID in SSM
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${local.name_prefix}/vpc_id"
  type  = "SecureString"
  value = aws_vpc.main.id
  tags  = local.common_tags

  depends_on = [aws_vpc.main]
}

# Store Public Subnet IDs in SSM
resource "aws_ssm_parameter" "public_subnet_ids" {
  name       = "/${local.name_prefix}/public_subnet_ids"
  type       = "StringList"
  value      = join(",", aws_subnet.public[*].id)
  depends_on = [aws_subnet.public]

  tags = local.common_tags
}

# Store App Private Subnet IDs in SSM
resource "aws_ssm_parameter" "app_private_subnet_ids" {
  name  = "/${local.name_prefix}/app_private_subnet_ids"
  type  = "StringList"
  value = join(",", aws_subnet.app_private[*].id)


  tags       = local.common_tags
  depends_on = [aws_subnet.app_private]
}

# Store DB Private Subnet IDs in SSM
resource "aws_ssm_parameter" "db_private_subnet_ids" {
  name  = "/${local.name_prefix}/db_private_subnet_ids"
  type  = "StringList"
  value = join(",", aws_subnet.db_private[*].id)


  tags       = local.common_tags
  depends_on = [aws_subnet.db_private]
}

# Store Internet Gateway ID in SSM
resource "aws_ssm_parameter" "igw_id" {
  name       = "/${local.name_prefix}/igw_id"
  type       = "String"
  value      = aws_internet_gateway.igw.id
  depends_on = [aws_internet_gateway.igw]

  tags = local.common_tags
}

# Store Public Route Table ID in SSM
resource "aws_ssm_parameter" "public_rt_id" {
  name       = "/${local.name_prefix}/public_rt_id"
  type       = "String"
  value      = aws_route_table.public.id
  depends_on = [aws_route_table.public]

  tags = local.common_tags
}

# Store App Private Route Table ID in SSM
resource "aws_ssm_parameter" "app_private_rtb_id" {
  name  = "/${local.name_prefix}/private_rt_id"
  type  = "String"
  value = join(",", aws_route_table.app_private[*].id)
  # value      = aws_route_table.private.id
  depends_on = [aws_route_table.app_private]

  tags = local.common_tags
}

# Store DB Private Route Table ID in SSM
resource "aws_ssm_parameter" "db_private_rtb_id" {
  name       = "/${local.name_prefix}/db_private_rt_id"
  type       = "String"
  value      = aws_route_table.db_private.id
  depends_on = [aws_route_table.db_private]

  tags = local.common_tags
}

# Store NAT Gateway ID in SSM
resource "aws_ssm_parameter" "nat_ids" {
  name       = "/${local.name_prefix}/nat_ids"
  type       = "String"
  value      = join(",", aws_nat_gateway.nat[*].id)
  depends_on = [aws_nat_gateway.nat]

  tags = local.common_tags
}

