variable "environment" {
  description = "Environment resources belong to"
}

variable "appName" {
  description = "unique app identifier"
}

variable "address_space" { }
variable "region" { }
variable "subnets" { type = "list" }
variable "subnet_names" { type = "list" }

variable "number_of_seed_nodes" { }
variable "number_of_data_nodes" { }

variable "username" { }
variable "password" { }
