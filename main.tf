provider "azurerm" {
  features {}
  tenant_id = "${var.tenant_id}"
}

resource "azurerm_resource_group" "main" {
  name     = "${var.project_tag_value}"
  location = "${var.location}"

  tags = {
    "project" = "${var.project_tag_value}"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-virtual-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    "project" = "${var.project_tag_value}"
  }
}

resource "azurerm_subnet" "main" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.prefix}-security-group"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    "project" = "${var.project_tag_value}"
  }
}

resource "azurerm_network_security_rule" "main" {
  name                        = "${var.prefix}-intra-network-communiction-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-public-ip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"

  tags = {
    "project" = "${var.project_tag_value}"
  }
}

resource "azurerm_lb" "main" {
 name                = "${var.prefix}-loadBalancer"
 resource_group_name = azurerm_resource_group.main.name
 location            = azurerm_resource_group.main.location

 frontend_ip_configuration {
   name                 = "${var.prefix}-public-ip"
   public_ip_address_id = azurerm_public_ip.main.id
 }

 tags = {
   "project" = "${var.project_tag_value}"
 }
}

resource "azurerm_lb_backend_address_pool" "main" {
 resource_group_name        = azurerm_resource_group.main.name
 loadbalancer_id            = azurerm_lb.main.id
 name                       = "${var.prefix}-backend-address-pool"
}

resource "azurerm_network_interface" "main" {
  count               = "${var.number_of_virtual_machines}"
  name                = "${var.prefix}-network-interface-card-${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "${var.prefix}-internal-ip-${count.index}"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "dynamic"
  }

  tags = {
    "project" = "${var.project_tag_value}"
  }
}

resource "azurerm_availability_set" "main" {
 name                         = "${var.prefix}-availability_set"
 location                     = azurerm_resource_group.main.location
 resource_group_name          = azurerm_resource_group.main.name
 platform_fault_domain_count  = "${var.number_of_virtual_machines}"
 platform_update_domain_count = "${var.number_of_virtual_machines}"
 managed                      = true

 tags = {
   "project" = "${var.project_tag_value}"
 }
}

resource "azurerm_virtual_machine" "main" {
 count                 = "${var.number_of_virtual_machines}"
 name                  = "${var.prefix}-virtual-machine-${count.index}"
 location              = azurerm_resource_group.main.location
 availability_set_id   = azurerm_availability_set.main.id
 resource_group_name   = azurerm_resource_group.main.name
 network_interface_ids = [element(azurerm_network_interface.main.*.id, count.index)]
 vm_size               = "Standard_A1_v2"

 storage_image_reference {
   publisher = "Canonical"
   offer     = "UbuntuServer"
   sku       = "18.04-LTS"
   version   = "latest"
 }

 os_profile {
   computer_name  = "${var.prefix}-web-server-${count.index}"
   admin_username = "${var.admin_username}"
   admin_password = "${var.admin_password}"
 }

 os_profile_linux_config {
   disable_password_authentication = false
 }

 storage_os_disk {
   name              = "${var.prefix}-os-disk-${count.index}"
   caching           = "ReadWrite"
   create_option     = "FromImage"
   managed_disk_type = "Standard_LRS"
 }

 tags = {
   "project" = "${var.project_tag_value}"
 }
}
