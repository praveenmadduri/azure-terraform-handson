# 🌟 Golden Terraform Repository for Azure Infrastructure

This repository provides a **production-ready**, **multi-region**, and **modular** Terraform setup for deploying a fully wired Azure infrastructure. It includes reusable components, automation scripts, and is designed to be your team's **go-to baseline (golden repo)** for cloud deployments.

---

## 📌 Features

- 🔁 Reusable Terraform modules
- 🌍 Multi-region deployment (East US, Central US)
- 🔐 Secure VM access (SSH key)
- 🧱 RHEL Virtual Machines
- 📡 NSGs, VNETs, Subnets, NICs
- 📈 Azure Log Analytics integration
- 🛠️ Route Tables & Diagnostics support
- 📦 Remote state via Azure Storage backend
- 🎛️ Easily extendable with Bastion, Key Vault, Extensions, etc.

---

## 🏗️ Architecture Diagram (High-Level)

            +----------------------------+
            |        Azure Regions       |
            +----------------------------+
              |                      |
        +-----------+         +-----------+
        |  East US  |         | Central US|
        +-----------+         +-----------+
            |                      |
     +-------------+        +--------------+
     | rg-eastus   |        | rg-centralus |
     +-------------+        +--------------+
            |                      |
       +---------+            +---------+
       |  VNet   |            |  VNet   |
       +---------+            +---------+
       | Subnet  |            | Subnet  |
       | + NSG   |            | + NSG   |
       +---------+            +---------+
            |                      |
       +----------+           +----------+
       |   NIC    |           |   NIC    |
       +----------+           +----------+
            |                      |
       +----------+           +----------+
       |  RHEL VM |           |  RHEL VM |
       +----------+           +----------+

---

## 📂 Directory Structure

golden_terraform/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── backend.tf
├── deploy.sh
├── deploy.ps1
├── README.md
└── modules/
├── network/
│ ├── vnet/
│ ├── nsg/
│ ├── nic/
│ ├── route_table/
├── diagnostics/
├── bastion/
└── rhel_vm/


---

## 📥 Requirements

- [Terraform ≥ 1.3](https://developer.hashicorp.com/terraform/downloads)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- SSH key pair
- Azure Subscription with permissions

---

## ⚙️ Sample `terraform.tfvars`

```hcl
# Azure Subscription
subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
tenant_id       = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"

# Backend
backend_rg              = "rg-terraform-backend"
backend_storage_account = "tfstatestorageprod"
backend_container       = "tfstate"
backend_key             = "prod/terraform.tfstate"

# VM Settings
vm_size        = "Standard_B2ms"
admin_username = "azureuser"

# SSH Public Key
admin_ssh_key = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArK1q3ZgOqXfj...
EOF

# Log Analytics Workspace
log_analytics_workspace_id = "/subscriptions/xxx/resourceGroups/rg-logs/providers/Microsoft.OperationalInsights/workspaces/log-analytics-prod"

# NSG Rules
nsg_rules = [
  {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]
🚀 Deployment Steps
1. Authenticate with Azure
az login
az account set --subscription "<your-subscription-id>"

2. Initialize Terraform
terraform init

3. Plan the deployment
terraform plan -out=tfplan

4. Apply the plan
terraform apply tfplan