# Target Group
resource "aws_lb_target_group" "alb_target_group" {
  name        = local.target_group_name
  port        = var.health_check_port
  protocol    = var.health_check_protocol
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  target_type = var.target_type # "instance" or "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  lifecycle {
    ignore_changes = [
      name,
      port,
      protocol,
      target_type,
      vpc_id
    ]
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = local.target_group_name
  })
}

# Create the ALB
resource "aws_lb" "alb" {
  name               = local.alb_name
  internal           = false
  load_balancer_type = var.alb_type
  security_groups    = [data.aws_ssm_parameter.alb_sg_id.value]
  subnets            = split(",", data.aws_ssm_parameter.public_subnet_ids.value)

  # Ensure that ALB drops HTTP headers
  drop_invalid_header_fields = true

  access_logs {
    bucket  = data.aws_s3_bucket.alb_logs.id
    prefix  = terraform.workspace
    enabled = true
  }

  enable_deletion_protection = terraform.workspace == "prod" ? true : false

  tags = merge(local.common_tags, {
    Name = local.alb_name
  })
}

# HTTP to HTTPS redirect
resource "aws_lb_listener" "http_redirect" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.test_port
  protocol          = var.test_protocol

  default_action {
    type             = "redirect"
    target_group_arn = aws_lb_target_group.alb_target_group.arn

    redirect {
      protocol    = var.traffic_protocol
      port        = var.redirect_port
      status_code = "HTTP_301"
    }
  }
}

# HTTPS Listener (Handles Secure Traffic)
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_https_port
  protocol          = var.traffic_protocol
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = data.aws_iam_server_certificate.iam_cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}