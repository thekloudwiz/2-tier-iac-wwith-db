# Create EIP for NAT Gateway According to AZs
resource "aws_eip" "nat_eip" {
  count  = var.availability_zones_count
  domain = "vpc"

  tags = merge(local.common_tags, {
    Name = "${local.nat_eip_name}-${count.index + 1}"
  })
}

# Create NAT Gateway According to AZs
resource "aws_nat_gateway" "nat" {
  count         = var.availability_zones_count
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(local.common_tags, {
    Name = "${local.nat_name}-${count.index + 1}"
  })

  depends_on = [aws_eip.nat_eip]
}

# # !Use this if you want to create a single NAT Gateway
# # Create EIP
# resource "aws_eip" "nat_eip" {
#   domain = "vpc"

#   tags = merge(local.common_tags, {
#     Name = "${local.name_prefix}-nat-eip"
#   })
# }

# # !Use this if you want to create a single NAT Gateway
# # Create NAT Gateway
# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.public[0].id

#   tags = merge(local.common_tags, {
#     Name = "${local.name_prefix}-nat"
#   })

#   depends_on = [aws_eip.nat_eip]
# }