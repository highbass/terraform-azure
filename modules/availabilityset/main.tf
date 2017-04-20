#############################
##  Create Availability Set ##
############################

resource "azurerm_availability_set" "default" {
  name                = "as_${var.as_name}"
  location            = "${var.as_region}"
  resource_group_name = "${var.as_resourcegroup}"
  platform_update_domain_count = 20
  platform_fault_domain_count = 2
  managed = true

  tags {
    Name = "as_${var.as_name}"
    Environment = "${var.environment}"
    Application = "${var.appname}"
    Role = "availability set"
  }
}
