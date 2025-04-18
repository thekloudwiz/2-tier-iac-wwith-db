data "aws_elb_service_account" "main" {}


# Fetch Logs Bucket Name from SSM Parameter Store
data "aws_ssm_parameter" "alb_logs" {
  name = "/${local.name_prefix}/alb_logs"

  depends_on = [aws_ssm_parameter.alb_logs]
}