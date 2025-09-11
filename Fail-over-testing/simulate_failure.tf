resource "null_resource" "simulate_failure" {
  provisioner "local-exec" {
    command = "az network vnet delete --name vnet-eastus --resource-group rg-eastus"
  }
}