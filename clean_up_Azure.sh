# Show the stack, that was created in Azure
terraform show
# Destroy the stack in Azure
terraform destroy
# Show the image in Azure
az image show
# Delete the image in Azure
az image delete -g images-4-udacity-devops-4-azure-nanodegree -n image
# Delete the resource group for the images
az group delete --resource-group images-4-udacity-devops-4-azure-nanodegree -y
