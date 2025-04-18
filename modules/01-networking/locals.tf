locals {
  # Naming convention for resources
  name_prefix = "${var.project_name}-${terraform.workspace}-${var.region}"

  # Common tags for all resources
  common_tags = {
    Environment = terraform.workspace
    Managed_by  = var.managed_by
    Owner       = var.owner
    Project     = "${var.project_name}"
  }

  # Resource specific names
  vpc_name                = "${local.name_prefix}-vpc"
  igw_name                = "${local.name_prefix}-igw"
  public_subnet_name      = "${local.name_prefix}-public-subnet"
  db_private_subnet_name     = "${local.name_prefix}-db-private-subnet"
  app_private_subnet_name = "${local.name_prefix}-app-private-subnet"
  public_rtb_name         = "${local.name_prefix}-public-rtb"
  app_private_rtb_name        = "${local.name_prefix}-private-rtb"
  db_private_rtb_name        = "${local.name_prefix}-db-private-rtb"
  nat_gateway_name        = "${local.name_prefix}-nat-gateway"
  nat_eip_name            = "${local.name_prefix}-nat-eip"
  nat_name                = "${local.name_prefix}-nat"
}