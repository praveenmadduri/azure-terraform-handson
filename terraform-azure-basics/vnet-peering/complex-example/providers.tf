terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.0"
        }
    }
}

provider "azurerm" {
    alias   = "subscription1"
    features {}
    subscription_id = "SUBSCRIPTION_ID_1"
}

provider "azurerm" {
    alias   = "subscription2"
    features {}
    subscription_id = "SUBSCRIPTION_ID_2"
}