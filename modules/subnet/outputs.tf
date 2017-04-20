output "id" {
  value = "${azurerm_subnet.default.id}"
}

output "name" {
  value = "${azurerm_subnet.default.name}"
}

output "ip_configurations" {
  value = ["${azurerm_subnet.default.ip_configurations}"]
}
