#############################
##  Create Virtual Machine ##
############################
resource "azurerm_public_ip" "default" {
  name                = "pip_${var.vm_name}-${format("%02d", count.index)}"
  location            = "${var.vm_region}"
  resource_group_name = "${var.vm_resourcegroup}"
  public_ip_address_allocation = "dynamic"

  tags {
    Name = "pip_${var.vm_name}-${format("%02d", count.index)}"
    Environment = "${var.environment}"
    Application = "${var.appname}"
    Role = "PublicIP"
  }
  count = "${var.vm_count}"
}

resource "azurerm_network_interface" "default" {
  name                = "ni_${var.vm_name}-${format("%02d", count.index)}"
  location            = "${var.vm_region}"
  resource_group_name = "${var.vm_resourcegroup}"
  network_security_group_id = "${var.vm_securitygroup}"

  ip_configuration {
    name                          = "${var.vm_name}-${format("%02d", count.index)}"
    subnet_id                     = "${var.vm_subnetid}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${element(azurerm_public_ip.default.*.id, count.index)}"
  }

  tags {
    Name = "ni_${var.vm_name}"
    Environment = "${var.environment}"
    Application = "${var.appname}"
    Role = "NetworkInterface"
  }

  count = "${var.vm_count}"
}

resource "azurerm_managed_disk" "default" {
  name                = "md_${var.vm_name}-${format("%02d", count.index)}"
  location            = "${var.vm_region}"
  resource_group_name = "${var.vm_resourcegroup}"
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = "200"

  tags {
    Name = "ni_${var.vm_name}"
    Environment = "${var.environment}"
    Application = "${var.appname}"
    Role = "ManagedDisk"
  }

  count = "${var.vm_count}"
}

resource "azurerm_virtual_machine" "default" {
  name                  = "vm_${var.vm_name}-${format("%02d", count.index)}"
  location            = "${var.vm_region}"
  resource_group_name = "${var.vm_resourcegroup}"
  network_interface_ids = ["${element(azurerm_network_interface.default.*.id, count.index)}"]
  vm_size               = "${var.vm_machine_type}"
  availability_set_id  = "${var.vm_availabilityset}"
  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osd_${var.vm_name}-${format("%02d", count.index)}"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_data_disk {
    name            = "${element(azurerm_managed_disk.default.*.name, format("%02d", count.index))}"
    managed_disk_id = "${element(azurerm_managed_disk.default.*.id, count.index)}"
    create_option   = "Attach"
    lun             = 1
    disk_size_gb    = "${element(azurerm_managed_disk.default.*.disk_size_gb, count.index)}"
  }

  os_profile {
    computer_name  = "osd-${var.vm_name}-${format("%02d", count.index)}"
    admin_username = "${var.vm_username}"
    admin_password = "${var.vm_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/${var.vm_username}/.ssh/authorized_keys"
      key_data = "${file("/Users/zbutt/.ssh/id_rsa.pub")}"
    }
  }

  tags {
    Name = "ni_${var.vm_name}"
    Environment = "${var.environment}"
    Application = "${var.appname}"
    Role = "${var.vm_type}"
  }

  count = "${var.vm_count}"
}
