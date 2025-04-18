# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_ssm_parameter.vpc_id.value

  route {
    cidr_block = var.public_route_table_destination_cidr
    gateway_id = aws_ssm_parameter.igw_id.value
  }

  tags = merge(local.common_tags, {
    Name = local.public_rtb_name
  })
}

# Associate route table with public subnets
resource "aws_route_table_association" "public" {
  count          = var.availability_zones_count
  subnet_id      = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[count.index]
  route_table_id = aws_ssm_parameter.public_rt_id.value
}

# Create App Private Route Table
resource "aws_route_table" "app_private" {
  vpc_id = aws_ssm_parameter.vpc_id.value
  count = var.availability_zones_count

  route {
    cidr_block     = var.public_route_table_destination_cidr
    nat_gateway_id = split(",", data.aws_ssm_parameter.nat_ids.value)[count.index]
  }

  tags = merge(local.common_tags, {
    Name = "${local.app_private_rtb_name}" #local.private_rtb_name
  })
}

# Associate route table with App private subnets
resource "aws_route_table_association" "private" {
  count          = var.availability_zones_count
  subnet_id      = aws_subnet.app_private[count.index].id
  route_table_id = aws_route_table.app_private[count.index].id
  
  depends_on     = [aws_route_table.app_private]
}

# Create DB Private Route Table with only local route
resource "aws_route_table" "db_private" {
  vpc_id = aws_ssm_parameter.vpc_id.value

  tags = merge(local.common_tags, {
    Name = local.db_private_rtb_name
  }) 
}