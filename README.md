# AWS Terraform
Welcome! This repository is dedicated to managing AWS infrastructure with Terraform.

## Table of Contents
- [Convention](#convention)
- [License](#license)
- [Disclaimer](#disclaimer)

### Convention
- backend.tf file contains backend configuration in order to separate your backend configuration from your Terraform and provider versioning configuration.
- main.tf file contains all resource and data source blocks.
- outputs.tf file contains all output blocks in alphabetical order.
- providers.tf file contains all provider blocks and configuration.
- terraform.tf file contains a single terraform block which defines your required_version and required_providers.
- variables.tf file contains all variable blocks in alphabetical order.
- locals.tf file contains local values.
- override.tf file contains override definitions for your configuration. Terraform loads this and all files ending with _override.tf last.
- network.tf file contains VPC, subnets, load balancers, and all other networking resources.
- storage.tf file contains object storage and related permissions configuration.
- compute.tf file contains compute instances.

### License
This project is licensed under the MIT License. See the LICENSE file for more details.

### Disclaimer
This project is provided as-is, and the authors are not responsible for any damages or losses resulting from its use. Always test security measures in a staging environment before applying them to a prod site.
