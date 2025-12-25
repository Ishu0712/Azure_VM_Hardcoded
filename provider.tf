terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "4.1.0"
      }
    }
}

provider "azurerm" {
   features {}
   subscription_id = "5d80a2ab-5490-438c-8f91-82a4fb09c0d1"
}