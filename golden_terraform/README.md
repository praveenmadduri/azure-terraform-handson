# Golden Terraform Repository for Azure Infrastructure

Welcome! This repository contains reusable Terraform modules and example configurations to help you provision Azure infrastructure quickly and consistently. This guide is designed for beginners and explains how to deploy an Azure Resource Group, Virtual Network, and provision a Red Hat Enterprise Linux (RHEL) Virtual Machine.

---

## What you will learn

- Setting up Terraform environment
- Configuring variables for Azure resources
- Deploying network infrastructure with Virtual Network and Subnets
- Provisioning a RHEL VM connected to the network
- Using modules for reusable, clean Terraform code

---

## Prerequisites

Before you start, ensure you have:

1. [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed (version 1.4+ recommended)
2. [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed and logged in (`az login`)
3. An Azure subscription and permissions to create resources
4. Basic familiarity with command-line tools and Azure concepts

---

## Repository Structure Overview

golden_terraform/
├── modules/ # Reusable Terraform modules for components
│ ├── resource_group/
│ ├── network/
│ │ ├── vnet/
│ │ ├── nsg/
│ │ ├── public_ip/
│ │ └── nic/
│ ├── rhel_vm/
│ ├── log_analytics/
│ ├── key_vault/
│ └── private_dns/
├── environments/
│ └── multi-region/
│ ├── main.tf # Main deployment file
│ ├── variables.tf # Variables declarations
│ ├── terraform.tfvars # Variables values (configure here)
│ ├── backend.tf # Backend config for state storage
│ └── outputs.tf # Outputs for important resource info
└── README.md # This file


---

---

## Step-by-step Usage Guide

### Step 1: Clone or create this repository

If you have this repo already, great! Otherwise, run this setup script and add your modules & configs.

```bash
git clone https://github.com/your-org/golden_terraform.git
cd golden_terraform/environments/multi-region
Step 2: Configure your variables

Open the terraform.tfvars file in your environment folder and update the values:

subscription_id: Your Azure subscription ID

tenant_id: Your Azure AD tenant ID

admin_object_id: Object ID of your Azure AD user/service principal (for Key Vault access)

Resource group names and locations (e.g., eastus, westus2)

Virtual network CIDR and subnet definitions

NSG rules (pre-configured for SSH)

VM admin username and strong password

VM size (e.g., Standard_B2s)

Important: Never commit secrets like passwords to public repos!

Step 3: Configure backend state (optional but recommended)

Edit backend.tf to point to your Azure Storage Account container where Terraform state will be stored securely.

Step 4: Initialize Terraform

Run this command to download providers and initialize the backend:

terraform init

Step 5: Review the Terraform plan

Always preview the changes before applying:

terraform plan -var-file=terraform.tfvars

Step 6: Apply and provision resources

Run the apply command and confirm when prompted:

terraform apply -var-file=terraform.tfvars


Terraform will create:

Resource Groups in each region

Virtual Networks and Subnets with NSGs

Public IP and NIC

RHEL Virtual Machine configured to connect to the network

Log Analytics workspace and Key Vault


[ Resource Group (East US) ]
      |
      +--> Virtual Network (10.10.0.0/16)
            |
            +--> Subnet (10.10.1.0/24) with NSG attached
                  |
                  +--> NIC with Public IP
                        |
                        +--> RHEL VM

Other components:
- Log Analytics workspace in the Resource Group
- Key Vault in the Resource Group
- Private DNS zone for secure internal name resolution


