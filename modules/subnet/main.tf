#############################
##  Create Virtual Network ##
#############################

resource "azurerm_subnet" "default" {
  name                 = "${var.sn_subnet_names[count.index]}"
  resource_group_name  = "${var.sn_resourcegroup}"
  virtual_network_name = "${var.sn_vn_name}"
  address_prefix       = "${var.sn_subnet[count.index]}"

  count = "${length(var.sn_subnet)}"
}
