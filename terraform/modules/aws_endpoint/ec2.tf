resource "aws_vpc_endpoint" "ec2_endpoint" {
  count             = var.service == "ec2" ? 1 : 0
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.ec2"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [for subnet, id in var.subnets : id]
  security_group_ids = [
    aws_security_group.ec2_endpoint[0].id
  ]
  private_dns_enabled = true
  tags                = merge(local.rc_tags, var.tags)
}

resource "aws_security_group" "ec2_endpoint" {
  count  = var.service == "ec2" ? 1 : 0
  name   = "${var.profile}-vpc-endpoint-ec2"
  vpc_id = var.vpc_id
  tags   = merge(local.rc_tags, var.tags)

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
}

