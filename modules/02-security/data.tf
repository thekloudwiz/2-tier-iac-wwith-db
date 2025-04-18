# Retrieve VPC ID from SSM
data "aws_ssm_parameter" "vpc_id" {
  name = "/${local.name_prefix}/vpc_id"
}

# Retrieve Kafka Security Group ID from SSM
data "aws_ssm_parameter" "kafka_sg_id" {
  name = "/${local.name_prefix}/kafka_sg_id"

  depends_on = [aws_ssm_parameter.kafka_sg_id]
}