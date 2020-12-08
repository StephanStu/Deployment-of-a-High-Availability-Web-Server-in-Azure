# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

## Introduction
This is my solution for the 1st project in Udacity's DevOps Engineer for Azure Nanodegree Program.
This goal of this project is to provide infrastructure-as-code for a high availability, scalable web server that is deployed in Microsoft Azure. To deploy the infrastructure, you must leverage Terraform and Packer as decribed below.

## Getting Started / Summary
### 1. Prepare the local environment
This section explains how to set up a desktop computer or workstation (Linux or MacOS) for this project.  
Run every command inside a clone of this repository.

#### Verify installation of tools
After installing all tools listed in the Dependencies-section, run the following checks to be sure, that your environment is ready.

* Run `$ az --version`, to make sure, the Azure command line interface is installed (this command should return `2.15.1` or higher). Login by running `$ az login`.
* Run `packer --version` to check, that Packer is installed (this command should return `1.6.5` or higher).
* Run `terraform --version` to check, that Terraform is installed (this command should return `v0.14.0` or higher).

#### Give credentials to Terraform & Packer
Terraform must be given necessary credentials in Azure in order to be able so spawn resources as defined in the artifacts.

* Create a service principle in Azure for Terraform.
* Run `az login` to log into your Azure account. Now get the tenant-id by running `az account show`. Paste the tenant id as `default = "XXX"` into vars.tf in the tenant_id-section.
* Run `terraform init` to get started. Terraform will now draw necessary packages, as successful init will return *Terraform has been successfully initialized!*.

Packer must be given necessary credentials in Azure, too. To create a service principle in Azure for Packer as explained [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer),   
* Run `$ az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"`.
* Create the following environment variable using the output of the last command: `ARM_CLIENT_ID` and `ARM_CLIENT_SECRET`
* Run `$ az account show --query "{ subscription_id: id }"`.
* Create the following environment variable using the output of the last command: `ARM_SUBSCRIPTION_ID`


### 2. Create your infrastructure as code
This section explains hot to provision the infrastructure for the high-availability web server in Azure.
Create the resource group first, such that it is ready for Packer to deploy the virtual machine image by running `az group create --name udacity-devops-4-azure-nanodegree --location "West Europe" --tags "project=udacity-devops-4-azure-nanodegree"`.


`terraform init` (if you have not already)
`terraform plan`
`terraform apply`
`terraform show`
`terraform destroy`

### 3. Inspect your infrastructure in Microsoft Azure

### 4. Destroy your infrastructure in Microsoft Azure

## Dependencies
These dependencies must be settled before the infrastructure can be deployed in Microsoft Azure.
1. Create an [Azure Account](https://portal.azure.com)
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
**Your words here**

### Output
**Your words here**
