variable "ARM_SUBSCRIPTION_ID" {}
variable "ARM_CLIENT_ID" {}
variable "ARM_CLIENT_SECRET" {}
variable "ARM_TENANT_ID" {}
variable "ARM_LOCATION" {
    description = "Azure region to launch servers"
    default = "West US"
}
variable "ARM_NETWORK_RESOURCE_GROUP" {
    description = "Name to give new resource group for Vnet"
}
