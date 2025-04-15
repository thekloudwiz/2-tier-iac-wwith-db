# AWS Region
region = "us-west-2"

# Project Name
project_name = "my-project"

# Owner of the resources
owner = "my-name"

# Environment name
environment = "dev"

# Managed by information
managed_by = "terraform"

# VPC CIDR Block
vpc_cidr = "10.0.0.0/16"

# AWS Key Pair Name
keypair_name = "my_key_pair"

# Allowed CIDR Blocks
allowed_cidr_blocks = ["0.0.0.0/0"]

public_route_table_destination_cidr = "0.0.0.0/0"

# Availability Zones Count
availability_zones_count = 2

# SSH Port
ssh_port = 5000

# RDS Port
rds_port = 3306

# Outbound Port
outbound_port = 0

# Test Protocol
test_protocol = "tcp"

# Protocol
protocol = "tcp"

# ALB HTTPS Port
alb_https_port = 443

# ALB Type
alb_type = "application"

# Health Check Port
health_check_port = 80

# Health Check Protocol
health_check_protocol = "HTTP"

# Redirect Port
redirect_port = 80

# Test Port
test_port = 80

# Traffic Port
traffic_port = 443

# Traffic Protocol
traffic_protocol = "tcp"


# DB Instance Class
db_instance_class = "db.t3.micro"

# DB Storage Size
db_storage_size = 20

# DB Engine
db_engine = "mysql"

# DB Username
db_username = "admin"

# SSM Full Access Policy ARN
ssm_fullaccess_policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"

# SSM Maintenance Window Policy ARN
ssm_maintenance_window_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMMaintenanceWindowRole"

# SSM Managed Instance Core Policy ARN
ssm_managed_instance_core_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMManagedInstanceCore"

# IAM EC2 SSM Policy ARN
iam_ec2_ssm_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"

# AWS Budgets Actions with SSM Policy ARN
aws_budgets_actions_with_ssm_policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBudgetsActionsWithSSMPolicy"

# EC2 Full Access Policy ARN
ec2_full_access_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"

# RDS Full Access Policy ARN
rds_full_access_policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"

# EC2 Instance Type
ec2_instance_type = "t3.micro"

# EC2 Instance Class
ec2_instance_class = "t3"

# EC2 Instance Count
ec2_instance_count = 1

asg_config = {
  min                       = 1
  desired                   = 2
  max                       = 3
  health_check_grace_period = 300
  health_check_type         = "ELB"
}

# Launch Template Name
launch_template_name = "my_launch_template"

# Allow Public IP Association
allow_public_ip_association = true

# EC2 Instance Profile
iam_instance_profile = "my_instance_profile"

# Specification for CPU Credits
ec2_instance_cpu_credits = "unlimited"

# EC2 Instance Monitoring
ec2_instance_monitoring = true

# EC2 Instance EBS Optimized
ec2_instance_ebs_optimized = false

# EC2 Instance EBS Block Device Specification
ebs_block_device = {
  device_name           = "sda1"
  volume_size           = 20
  volume_type           = "gp3"
  delete_on_termination = true
  encrypted             = true
}

# Kafka Broker Nodes
kafka_broker_nodes = 3

# Kafka Node Type
kafka_node_type = "kafka.m5.large"

# Parameter Group Name
elasticache_parameter_group_name = "my_parameter_group"

# Kafka Version
kafka_version = "2.8.0"

# AWS ElastiCache Engine
elasticache_engine = "redis"

# Elasticache Port
elasticache_port = 6379

# Domain Name
wildcard_domain_name = "*.thekloudwiz.com"

# ACM Certificate ARN
iam_cert_name = "portfolio-thekloudwiz-com"

# Kafka Port
kafka_port = 9092