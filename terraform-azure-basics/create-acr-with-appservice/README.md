# Multi-Region ACR with App Service & VNet Peering (Terraform Example)

This example provisions:
- Multi-region Azure Container Registry (ACR) with geo-replication
- App Service (Linux) per region, using Docker images from ACR
- Separate Virtual Networks per region
- Full mesh VNet peering between regions

## Architecture

```
+----------+         +----------+
| VNet 1   |<------->| VNet 2   |
| (eastus) |         | (westeu) |
+----+-----+         +----+-----+
     |                    |
 App Service         App Service
     |                    |
    ACR ------geo-------->ACR replica
```

## Usage

1. Ensure you are authenticated to Azure with `az login`.
2. Initialize Terraform:
   ```sh
   terraform init
   ```
3. Apply:
   ```sh
   terraform apply
   ```
   - Outputs will show ACR login server and App Service URLs.

4. To add more regions, update `regions` in `variables.tf`.

## Notes
- App Service uses a public sample Docker image (`hello-world`). Change `linux_fx_version` in `main.tf` to use your own image.
- ACR geo-replication requires Premium SKU.
- VNets are peered for inter-region communication.
- App Service is configured for Docker container deployment from ACR.

## Cleanup

```sh
terraform destroy
```