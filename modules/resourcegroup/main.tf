#############################
##  Create Resource Group ##
############################
resource "azurerm_resource_group" "default" {
  name           = "${var.rg_name}"
  location       = "${var.rg_region}"

  tags {
    Name = "rg_${var.rg_name}"
    Environment = "${var.environment}"
    Application = "${var.appname}"
    Role = "Resource Group"
  }
}
