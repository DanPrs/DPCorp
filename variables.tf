# Configured as a variable in the Terraform Cloud portal
variable "subscription_id" {
  type = string
}

# Configured as a variable in the Terraform Cloud portal
variable "client_id" {
  type = string
}

# Configured as a variable in the Terraform Cloud portal
variable "client_secret" {
  type = string
}

# Configured as a variable in the Terraform Cloud portal
variable "tenant_id" {
  type = string
}

# Azure default resource location
variable "location" {
  default = "East US"
}
