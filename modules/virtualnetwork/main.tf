#############################
##  Create Virtual Network ##
#############################

resource "azurerm_virtual_network" "default" {
  name                = "vnet_${var.vn_name}"
  address_space       = ["${split(",",var.vn_blocks)}"]
  location            = "${var.vn_region}"
  resource_group_name = "${var.vn_resourcegroup}"

  tags {
    Name = "rg_${var.vn_name}"
    Environment = "${var.environment}"
    Application = "${var.appname}"
    Role = "VNET"
  }
}
