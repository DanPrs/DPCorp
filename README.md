# Terraform Playgroung

This is an example Terraform configuration in Azure. It uses Terraform Cloud to configure the environment. 

## What will this do?

This is a Terraform configuration that will create a standard Azure VNet architecture. Other resources may be deployed for testing.  

## What are the prerequisites?

You must have an Azure account and subscription. A Terraform cloud account and of course, GitHub account.

The values for `subscription_id`, `client_id`, `client_secret` and `tenant_id`should be saved as environment variables on your workspace, in Terraform Cloud.