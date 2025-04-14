
# Create a storage bucket
module "storage" {
  source       = "./modules/00-storage"
  environment  = var.environment
  project_name = var.project_name
  managed_by   = var.managed_by
  owner        = var.owner
  region       = var.region
}

# Create Networking Environment
module "networking" {
  source                              = "./modules/01-networking"
  vpc_cidr                            = var.vpc_cidr
  public_route_table_destination_cidr = var.public_route_table_destination_cidr
  allowed_cidr_blocks                 = var.allowed_cidr_blocks
  availability_zones_count            = var.availability_zones_count
  environment                         = var.environment
  project_name                        = var.project_name
  managed_by                          = var.managed_by
  owner                               = var.owner
  region                              = var.region
}

# Create Security Module
module "security" {
  source              = "./modules/02-security"
  ssh_port            = var.ssh_port
  rds_port            = var.rds_port
  elasticache_port    = var.elasticache_port
  kafka_port          = var.kafka_port
  outbound_port       = var.outbound_port
  alb_https_port      = var.alb_https_port
  allowed_cidr_blocks = var.allowed_cidr_blocks
  environment         = var.environment
  project_name        = var.project_name
  managed_by          = var.managed_by
  owner               = var.owner
  region              = var.region

  depends_on = [module.networking]
}

# Create Load Balancer Module
module "load_balancer" {
  source                = "./modules/03-loadbalancer"
  alb_type              = var.alb_type
  health_check_port     = var.health_check_port
  health_check_protocol = var.health_check_protocol
  redirect_port         = var.redirect_port
  test_port             = var.test_port
  test_protocol         = var.test_protocol
  traffic_port          = var.traffic_port
  traffic_protocol      = var.traffic_protocol
  alb_https_port        = var.alb_https_port
  environment           = var.environment
  project_name          = var.project_name
  managed_by            = var.managed_by
  wildcard_domain_name  = var.wildcard_domain_name
  iam_cert_name         = var.iam_cert_name
  owner                 = var.owner
  region                = var.region

  depends_on = [module.networking, module.security]
}

# Create Database Module
module "database" {
  source            = "./modules/04-database"
  db_instance_class = var.db_instance_class
  db_engine         = var.db_engine
  db_storage_size   = var.db_storage_size
  db_username       = var.db_username
  environment       = var.environment
  project_name      = var.project_name
  managed_by        = var.managed_by
  owner             = var.owner
  region            = var.region

  depends_on = [module.networking, module.security]
}

# Create IAM Module
module "iam" {
  source                                   = "./modules/05-iam"
  rds_access                               = var.rds_full_access_policy_arn
  ec2_access                               = var.ec2_full_access_policy_arn
  iam_ssm_fullaccess_policy_arn            = var.ssm_fullaccess_policy_arn
  iam_ssm_maintenance_window_policy_arn    = var.ssm_maintenance_window_policy_arn
  iam_ssm_managed_instance_core_policy_arn = var.ssm_managed_instance_core_policy_arn
  iam_ec2_ssm_policy_arn                   = var.iam_ec2_ssm_policy_arn
  aws_budgets_actions_with_ssm_policy_arn  = var.aws_budgets_actions_with_ssm_policy_arn
  environment                              = var.environment
  project_name                             = var.project_name
  managed_by                               = var.managed_by
  owner                                    = var.owner
  region                                   = var.region
}

# Create Compute Module
module "compute" {
  source                                = "./modules/06-compute"
  asg_config                            = var.asg_config
  ec2_instance_count                    = var.ec2_instance_count
  ec2_instance_type                     = var.ec2_instance_type
  ec2_instance_class                    = var.ec2_instance_class
  ebs_block_device                      = var.ebs_block_device
  ec2_instance_cpu_credit_specification = var.ec2_instance_cpu_credits
  associate_public_ip_to_instance       = var.allow_public_ip_association
  ec2_instance_ebs_optimized            = var.ec2_instance_ebs_optimized
  ec2_instance_monitoring               = var.ec2_instance_monitoring
  iam_instance_profile                  = var.iam_instance_profile
  keypair_name                          = var.keypair_name
  launch_template_name                  = var.launch_template_name
  environment                           = var.environment
  project_name                          = var.project_name
  managed_by                            = var.managed_by
  owner                                 = var.owner
  region                                = var.region

  depends_on = [module.networking, module.security]
}

# Create Services Module
module "services" {
  source               = "./modules/07-services"
  elasticache_engine   = var.elasticache_engine
  elasticache_port     = var.elasticache_port
  kafka_version        = var.kafka_version
  broker_nodes         = var.kafka_broker_nodes
  node_type            = var.kafka_node_type
  parameter_group_name = var.elasticache_parameter_group_name
  environment          = var.environment
  project_name         = var.project_name
  managed_by           = var.managed_by
  owner                = var.owner
  region               = var.region

  depends_on = [module.networking, module.security]
}