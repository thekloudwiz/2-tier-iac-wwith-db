# Variables for Security Module

# Region
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

# Managed By
variable "managed_by" {
  description = "Managed by information"
  type        = string
}

# Owner
variable "owner" {
  description = "Owner information"
  type        = string
}

# Environment
variable "environment" {
  description = "Environment name"
  type        = string
}

# Project Name
variable "project_name" {
  description = "Project name"
  type        = string
}

# EC2 Instance Class
variable "ec2_instance_class" {
  description = "EC2 instance class"
  type        = string
}

# key pair name
variable "keypair_name" {
  description = "Key pair name for EC2 instances"
  type        = string
}

# EC2 Specific Variables
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

# Launch Template Name
variable "launch_template_name" {
  description = "Launch template name for the Auto Scaling group"
  type        = string
}

# Allow Public IP Association
variable "associate_public_ip_to_instance" {
  description = "Associate public IP address to the EC2 instance"
  type        = bool
}

# Instance Type
variable "ec2_instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

# EC2 Instance Profile
variable "iam_instance_profile" {
  description = "IAM instance profile for the EC2 instance"
  type        = string
}

# Specification for CPU Credits
variable "ec2_instance_cpu_credit_specification" {
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

# EC2 Instance EBS Block Device Specification
variable "ebs_block_device" {
  description = "EBS block device for the EC2 instance"
  type = object({
    device_name           = string
    volume_size           = number
    volume_type           = string
    delete_on_termination = bool
    encrypted             = bool
  })
}