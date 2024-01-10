variable "name" {}
variable "env" {}
variable "region" {}
variable "profile" {}
variable "workload" {}
variable "fqn" {}
variable "cmd_id" { default = "" }

variable "service" {}
variable "subnets" {}
variable "route_tables" {}
variable "vpc_id" {}
variable "cidr_block" {}
variable "tags" { default = {} }
