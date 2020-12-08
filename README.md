# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

## Introduction
This is my solution for the 1st project in Udacity's DevOps Engineer for Azure Nanodegree Program.
This goal of this project is to provide infrastructure-as-code for a high availability, scalable web server that is deployed in Microsoft Azure. To deploy the infrastructure, you must leverage Terraform and Packer as decribed below.

## Getting Started / Summary
## 1. Clone this repository & check the dependencies are satisfied
Run every command inside a clone of this repository. Then

* run `$ az --version`, to make sure, the Azure command line interface is installed. Login by running `$ az login`.
* create a service principle in Azure for Terraform.
* run `packer --version` to check, that Packer is installed (this command should return `1.6.5` or higher).
* run `terraform --version` to check, that Terraform is installed (this command should return `v0.14.0` or higher).

Packer must be given necessary credentials in azure, too. To create a service principle in Azure for Packer as explained [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer)  
* run `$ az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"`.
* Create the following environment variable using the output of the last command: `ARM_CLIENT_ID` and `ARM_CLIENT_SECRET`
* run `$ az account show --query "{ subscription_id: id }"`.
* Create the following environment variable using the output of the last command: `ARM_SUBSCRIPTION_ID`


### 2. Create your infrastructure as code

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
