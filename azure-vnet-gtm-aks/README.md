# Terraform Multi-Region Azure Deployment

This Terraform configuration enables the deployment of Azure resources across multiple regions dynamically. It uses Azure Storage as the backend for managing Terraform state and allows for easy customization through variables.

---

## Features
- **Multi-Region Deployment**: Dynamically deploy resources across multiple Azure regions.
- **State Management**: Uses Azure Storage for remote state management.
- **Customizable Variables**: Easily configure regions, resource group names, and backend storage settings.
- **Scalable Design**: Add or remove regions without modifying the core configuration.

---

## Prerequisites
Before using this configuration, ensure you have:
1. **Terraform Installed**: [Install Terraform](https://developer.hashicorp.com/terraform/downloads).
2. **Azure CLI Installed**: [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
3. **Azure Subscription**: An active Azure subscription with permissions to create resources.

---
