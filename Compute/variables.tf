variable "ARM_SUBSCRIPTION_ID" {}
variable "ARM_CLIENT_ID" {}
variable "ARM_CLIENT_SECRET" {}
variable "ARM_TENANT_ID" {}
variable "ARM_LOCATION" {
    description = "Azure region to launch servers"
    default = "West US"
}
variable "ARM_COMPUTE_RESOURCE_GROUP" {
    description = "Name to give new resource group for compute"
}
variable "ARM_ENVIRONMENT_TAG" {
    description = "Name of enviroment type"
    defaut = "Dev"
}
variable "ARM_SUBNET_ID" {
    description = "Provide the target subnet's ID"
}
variable "ARM_STORAGEACCT_NAME" {
    description = "provide globaly unique storage account name"
}