variable "tenant_id" {
  description = "This is the tenant_id, run 'az account show' at the command line to get it."
}

variable "prefix" {
  description = "The prefix which should be used for all resources in this project."
  default = "project-1"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default = "West Europe"
}

variable "admin_username" {
  description = "This is the user-name of the administrator of this virtual machine."
  default = "udacity_admin"
}

variable "admin_password" {
  description = "This is the password that the administrator of this virtual machine must use to log in."
  default = "udacity/4u"
}

variable "project_tag_value" {
  description = "Each taggable resource will have the project tag. Each project tag will take this value. This way we can track resources associated with this project."
  default = "udacity-devops-4-azure-nanodegree"
}

variable "number_of_virtual_machines" {
  description = "This is the number of virtual machines that must be created."
  default = 2
}
