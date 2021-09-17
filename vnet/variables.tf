# Azure default resource location
variable "location" {
  default = "East US"
}

variable "environment" {
  type = string
}

variable "address_space" {
  type = string
}

variable "dns_servers" {
  type = string
}

variable "sub1_address_prefix" {
  type = string
}

variable "sub2_address_prefix" {
  type = string
}

variable "sub3_address_prefix" {
  type = string
}
