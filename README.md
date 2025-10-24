# Infrastructure Automation with Bicep

This project provides a framework for automating infrastructure deployment using Bicep.

## Features

- Modular and reusable Bicep templates.
- Simplified infrastructure as code (IaC) management.
- Support for parameterization and environment-specific configurations.

## Prerequisites

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Bicep CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)
- Access to an Azure subscription.

## Getting Started

1. Clone the repository:
    ```bash
    git clone https://github.com/your-repo/infra-automation.git
    cd infra-automation
    ```

2. Validate a Bicep template:
    ```bash
    bicep build ./templates/main.bicep
    ```

3. Deploy resources:
    ```bash
    az deployment group create --resource-group <RESOURCE_GROUP> --template-file ./templates/main.bicep
    ```

## Project Structure

```
infra-automation/
│
├── templates/
│   ├── main.bicep        # Entry point for resource deployment
│   ├── modules/          # Reusable Bicep modules
│
├── parameters/
│   ├── dev.json          # Parameters for development
│   ├── prod.json         # Parameters for production
│
└── README.md             # Project documentation
```

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for any improvements.
