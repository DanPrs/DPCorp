# Azure default resource location
variable "location" {
  default     = "East US"
}

# Infrastructure environment
variable "environment" {
  type        = string
  description = "Infrastructure environment (Test/Prod)"
}

# VNet CIDR block
variable "address_space" {
  type        = list(string)
  description = "VNet CIDR block"
}

# DNS providers
variable "dns_servers" {
  type        = list(string)
  description = "DNS providers"
}

# Frontend subnet address range
variable "sub1_address_prefix" {
  type        = string
  description = "Frontend subnet address range"
}

# Application subnet address range
variable "sub2_address_prefix" {
  type        = string
  description = "Application subnet address range"
}

# Data subnet address range
variable "sub3_address_prefix" {
  type        = string
  description = "Data subnet address range"
}