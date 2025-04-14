# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "${local.vpc_name}"
  })

}


# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_ssm_parameter.vpc_id.value

  tags = merge(local.common_tags, {
    Name = "${local.igw_name}"
  })
}

# Create 2 public subnets
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name                     = "${local.public_subnet_name}-${count.index + 1}"
    "kubernetes.io/role/elb" = "1" # For EKS if needed later
    "Type"                   = "Public"
  })
}

# Create 2 private subnets
resource "aws_subnet" "private" {
  count             = var.availability_zones_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + var.availability_zones_count)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = merge(local.common_tags, {
    Name                     = "${local.private_subnet_name}-${count.index + 1}"
    "kubernetes.io/role/elb" = "1" # For EKS if needed later
    "Type"                   = "Private"
  })
}


# NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nat-eip"
  })
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nat"
  })

  depends_on = [aws_eip.nat_eip]
}


