resource "azurerm_container_group" "web_app_pub" {
  name                = "${var.name}-web_app_pub"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  os_type             = "Linux"

  image_registry_credential {
    server = "mjcr1.azurecr.io"
    username = "mjcr1"
    password = "bReqwBFdY3o1/DY6/Ro9mywRqLDv7+3AomY460KjhV+ACRDivJe7"
  }

  container {
    name   = "testhttp"
    image  = "mjcr1.azurecr.io/test/http"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "web"
  }
}