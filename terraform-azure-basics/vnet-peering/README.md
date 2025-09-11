# VNet Peering with Terraform

## Introduction

VNet Peering is a mechanism in Azure that allows two virtual networks (VNets) to communicate with each other privately. This is useful for scenarios where resources in different VNets need to interact without exposing traffic to the public internet.

This document provides:
1. A **simple example** of VNet peering between two VNets in the same subscription.
2. A **complex example** of VNet peering between VNets in different subscriptions.

---

## Prerequisites

- Terraform installed on your system.
- Azure CLI authenticated to your Azure account.
- Sufficient permissions to create VNets and configure VNet peering.

---

## Simple Example: VNet Peering in the Same Subscription

### Explanation

In this example:
- Two VNets (`vnet1` and `vnet2`) are created in the same subscription and region.
- VNet peering is established between them.

### Terraform Code

#### `providers.tf`
```hcl
terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.0"
        }
    }
}

provider "azurerm" {
    features {}
}