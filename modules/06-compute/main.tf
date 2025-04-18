### Admin EC2 Instance
resource "aws_instance" "admin" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.ec2_instance_type
  subnet_id            = split(",", data.aws_ssm_parameter.app_private_subnet_ids.value)[0]
  iam_instance_profile = data.aws_iam_instance_profile.admin_profile.name
  security_groups      = [data.aws_ssm_parameter.admin_sg_id.value]

  lifecycle {
    ignore_changes = [
      ami,
      instance_type,
      subnet_id,
      iam_instance_profile,
      security_groups,
      ]
  }

  tags = merge(local.common_tags,
    {
      Name = "${local.admin_server_name}"
  })
}

# Create Launch Template
resource "aws_launch_template" "ec2_instance" {
  name_prefix   = local.instance_name
  instance_type = var.ec2_instance_type
  image_id      = data.aws_ami.ubuntu.id
  # key_name      = var.keypair_name
  vpc_security_group_ids = [data.aws_ssm_parameter.asg_sg_id.value]

  iam_instance_profile {
    name = data.aws_iam_instance_profile.app_profile.name
  }

  block_device_mappings {
    device_name = "/${terraform.workspace}/${var.ebs_block_device.device_name}" # var.ebs_block_device.device_name

    ebs {
      volume_size           = var.ebs_block_device.volume_size
      volume_type           = var.ebs_block_device.volume_type
      delete_on_termination = var.ebs_block_device.delete_on_termination
      encrypted             = var.ebs_block_device.encrypted
    }
  }

  credit_specification {
    cpu_credits = var.ec2_instance_cpu_credit_specification
  }

  tag_specifications {
    resource_type = var.target_type

    tags = merge(local.common_tags,
      {
        Name = "${local.instance_name}"
    })
  }

  tags = merge(local.common_tags, {
    Name = "${local.instance_name}"
  })

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [data.aws_ssm_parameter.asg_sg_id]
}

# Create ASG for App Servers
resource "aws_autoscaling_group" "asg" {
  name                      = local.asg_name
  max_size                  = var.asg_config.max
  min_size                  = var.asg_config.min
  desired_capacity          = var.asg_config.desired
  health_check_grace_period = var.asg_config.health_check_grace_period
  health_check_type         = var.asg_config.health_check_type
  vpc_zone_identifier       = split(",", data.aws_ssm_parameter.app_private_subnet_ids.value)

  launch_template {
    id      = aws_launch_template.ec2_instance.id
    version = "$Latest"
  }

  target_group_arns = [data.aws_ssm_parameter.alb_target_group_arn.value]

  tag {
    key                 = "Name"
    value               = local.instance_name
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_launch_template.ec2_instance]
}

