# Project Name
variable "project_name" {
  description = "Name of the project"
  type        = string
}

# Owner of the resource
variable "owner" {
  description = "Owner of the resource"
  type        = string
}

# AWS Region
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

# Environment
variable "environment" {
  description = "Environment name"
  type        = string
}

# Resource Manager
variable "managed_by" {
  description = "Managed by information"
  type        = string
}

# VPC CIDR Block
variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

# Allowed CIDR Blocks
variable "allowed_cidr_blocks" {
  description = "Allowed CIDR Blocks"
  type        = list(string)
}

# Public Route
variable "public_route_table_destination_cidr" {
  description = "Destination CIDR block for public subnet route table"
  type        = string
}

# Availability Zones Count
variable "availability_zones_count" {
  description = "Number of availability zones"
  type        = number
}

# SSH Port
variable "ssh_port" {
  description = "SSH port for EC2 instances"
  type        = number
}

# RDS Port
variable "rds_port" {
  description = "RDS port for RDS instances"
  type        = number
}

# Outbound Port
variable "outbound_port" {
  description = "Outbound port for security group rules"
  type        = number
}

# Protocol
variable "protocol" {
  description = "Protocol for security group rules"
  type        = string
}

# ALB HTTPS Port
variable "alb_https_port" {
  description = "HTTPS port for ALB"
  type        = number
}

# ALB Type
variable "alb_type" {
  description = "Type of the ALB"
  type        = string
}

# Health Check Port
variable "health_check_port" {
  description = "Port for health check"
  type        = number
}

# Health Check Protocol
variable "health_check_protocol" {
  description = "Protocol for health check"
  type        = string
}

# Redirect Port
variable "redirect_port" {
  description = "Port for redirecting HTTP to HTTPS"
  type        = number
}

# Traffic Port
variable "traffic_port" {
  description = "Port for traffic"
  type        = number
}

# Test Port
variable "test_port" {
  description = "Test port for ALB listener"
  type        = number
}

# Test Protocol
variable "test_protocol" {
  description = "Test protocol for ALB listener"
  type        = string
}

# Traffic Protocol
variable "traffic_protocol" {
  description = "Protocol for traffic"
  type        = string
}

# DB Instance Class
variable "db_instance_class" {
  description = "DB instance class"
  type        = string
}

# DB Storage Size
variable "db_storage_size" {
  description = "DB storage size in GB"
  type        = number
}

# DB Engine
variable "db_engine" {
  description = "DB engine"
  type        = string
}

# DB Username
variable "db_username" {
  description = "Username for the database"
  type        = string
}

# SSM Full Access Policy ARN
variable "ssm_fullaccess_policy_arn" {
  description = "Amazon SSM Full Access policy ARN"
  type        = string
}

# SSM Maintenance Window Policy ARN
variable "ssm_maintenance_window_policy_arn" {
  description = "Amazon SSM Maintenance policy ARN"
  type        = string
}

# SSM Managed Instance Core Policy ARN
variable "ssm_managed_instance_core_policy_arn" {
  description = "Amazon SSM Managed Instance Core policy ARN"
  type        = string
}

# EC2 SSM Policy ARN
variable "iam_ec2_ssm_policy_arn" {
  description = "Amazon EC2 Role for SSM policy ARN"
  type        = string
}

# AWS Budgets Actions Role Policy for Resource Administration with SSM ARN
variable "aws_budgets_actions_with_ssm_policy_arn" {
  description = "AWS Budgets Actions Role Policy for Resource Administration with SSM ARN"
  type        = string
}

# EC2 Access Policy ARN
variable "ec2_full_access_policy_arn" {
  description = "EC2 access policy ARN"
  type        = string
}

# RDS Access Policy ARN
variable "rds_full_access_policy_arn" {
  description = "RDS access policy ARN"
  type        = string
}

# EC2 Instance Class
variable "ec2_instance_class" {
  description = "EC2 instance type"
  type        = string
}

# EC2 Instance type
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

# Keypair name
variable "keypair_name" {
  description = "Key pair name for EC2 instances"
  type        = string
}

# EC2 Instance Count
variable "ec2_instance_count" {
  description = "Number of EC2 instances"
  type        = number
}

# ASG Capacity Definitions
variable "asg_config" {
  type = object({
    max                       = number
    min                       = number
    desired                   = number
    health_check_grace_period = number
    health_check_type         = string
  })
  description = "Capacity definitions for the Auto Scaling group"
}

# EC2 Instance EBS Block Device Specification
variable "ebs_block_device" {
  type = object({
    device_name           = string
    volume_size           = number
    volume_type           = string
    delete_on_termination = bool
    encrypted             = bool
  })
  description = "EBS block device for the EC2 instance"
}

# Launch Template Name
variable "launch_template_name" {
  description = "Launch template name for the Auto Scaling group"
  type        = string
}

# Allow Public IP Association
variable "allow_public_ip_association" {
  description = "Associate public IP address to the EC2 instance"
  type        = bool
}

# EC2 Instance Profile
variable "iam_instance_profile" {
  description = "IAM instance profile for the EC2 instance"
  type        = string
}

# Specification for CPU Credits
variable "ec2_instance_cpu_credits" {
  description = "CPU credit specification for the EC2 instance"
  type        = string
}

# EC2 Instance Monitoring
variable "ec2_instance_monitoring" {
  description = "Monitoring for the EC2 instance"
  type        = bool
}

# EC2 Instance EBS Optimized
variable "ec2_instance_ebs_optimized" {
  description = "EBS optimized for the EC2 instance"
  type        = bool

}

# Kafka Broker Nodes
variable "kafka_broker_nodes" {
  description = "Number of broker nodes"
  type        = number
}

# Kafka Node Type
variable "kafka_node_type" {
  description = "Node type for the cluster"
  type        = string
}

# Parameter Group Name
variable "elasticache_parameter_group_name" {
  description = "Parameter group name for the cluster"
  type        = string
}

# Kafka Version
variable "kafka_version" {
  description = "Engine version for the cluster"
  type        = string
}

# AWS ElastiCache Engine
variable "elasticache_engine" {
  description = "Cluster engine for the ElastiCache cluster"
  type        = string
}

# ElastiCache Port
variable "elasticache_port" {
  description = "Port for the ElastiCache cluster"
  type        = number
}

# Wildcard Domain Name
variable "wildcard_domain_name" {
  description = "The wildcard domain name"
  type        = string
}

# IAM Certificate ARN
variable "iam_cert_name" {
  description = "The IAM certificate name"
  type        = string
}

# Kafka Port
variable "kafka_port" {
  description = "Kafka port"
  type        = number
}