# data "aws_route_table" "this" {
#   for_each = var.route_tables != "" ? toset(split(",", var.route_tables)) : []
#   filter {
#     name   = "tag:fqn"
#     values = [each.key]
#   }
# }

# data "aws_subnet" "this" {
#   for_each = var.subnets != "" ? toset(split(",", var.subnets)) : []
#   filter {
#     name   = "tag:fqn"
#     values = [each.key]
#   }
# }

locals {
  create_endpoint_sg = (
    var.service == "autoscaling" ||
    var.service == "ec2" ||
    var.service == "ecr_api" ||
    var.service == "ecr_dkr" ||
    var.service == "sqs" ||
    var.service == "sns" ? 1 : 0
  )

  # subnets      = [for subnet, details in data.aws_subnet.this : details.id]
  # route_tables = { for rtb, details in data.aws_route_table.this : rtb => details.id }

}

# output "subnets" { value = local.subnets }
# output "route_tables" { value = local.route_tables }

data "aws_region" "current" {}

data "aws_vpc" "current" {
  id = var.vpc_id
}

data "aws_vpc_endpoint_service" "s3_endpoint" {
  service      = "s3"
  service_type = "Gateway"
}

data "aws_vpc_endpoint_service" "dynamodb_endpoint" {
  service = "dynamodb"
}
