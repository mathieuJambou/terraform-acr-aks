output "container_ipv4_address" {
  value = azurerm_container_group.web_app_pub.ip_address
}