variable "name" {}
variable "env" {}
variable "profile" {}
variable "workload" {}
variable "fqn" {}
variable "cmd_id" { default = "" }

variable "route_tables" { default = "" }
variable "destination_cidr_block" { default = "" }
variable "transit_gateway_id" { default = "" }
variable "vpc_peering_connection_id" { default = "" }
