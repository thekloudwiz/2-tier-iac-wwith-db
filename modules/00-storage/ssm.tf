# Save Logs Bucket Name to SSM Parameter Store
resource "aws_ssm_parameter" "alb_logs" {
  name  = "/${local.name_prefix}/alb_logs"
  type  = "String"
  value = aws_s3_bucket.alb_logs.bucket

  depends_on = [aws_s3_bucket.alb_logs]
}