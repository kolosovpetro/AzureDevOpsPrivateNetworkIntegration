resource "azurerm_network_security_group" "public" {
  name                = "nsg-${var.prefix}"
  location            = azurerm_resource_group.public.location
  resource_group_name = azurerm_resource_group.public.name
}

resource "azurerm_network_security_rule" "allow_azure_resources" {
  name                         = "AllowAzureResourcesOutbound"
  priority                     = 100
  direction                    = "Outbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "*"
  source_address_prefix        = "*"
  destination_address_prefixes = local.azure_resources_cidr
  resource_group_name          = azurerm_resource_group.public.name
  network_security_group_name  = azurerm_network_security_group.public.name
}

resource "azurerm_network_security_rule" "deny_all_outbound" {
  name                        = "DenyAllOutbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.public.name
  network_security_group_name = azurerm_network_security_group.public.name
}

# resource "azurerm_network_security_rule" "allow_dns_udp" {
#   name                        = "AllowDNS"
#   priority                    = 110
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Udp"
#   source_port_range           = "*"
#   destination_port_range      = "53"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "168.63.129.16"
#   resource_group_name         = azurerm_resource_group.public.name
#   network_security_group_name = azurerm_network_security_group.public.name
# }

locals {
  azure_resources_cidr = [
    "13.107.42.0/24",       # dev.azure.com
    "13.107.6.0/24",        # vsblob.dev.azure.com
    "13.107.9.0/24",        # artifacts
    "52.239.192.0/19",      # Pipelines, agent pool endpoints
    "168.63.129.16",         # Azure DNS / metadata
    # azure devops cidr from JSON
    "20.37.158.0/23",
    "20.37.194.0/24",
    "20.39.13.0/26",
    "20.41.6.0/23",
    "20.41.194.0/24",
    "20.42.5.0/24",
    "20.42.134.0/23",
    "20.42.226.0/24",
    "20.45.196.64/26",
    "20.91.148.128/25",
    "20.125.155.0/24",
    "20.166.41.0/24",
    "20.189.107.0/24",
    "20.195.68.0/24",
    "20.204.197.192/26",
    "20.233.130.0/25",
    "40.74.28.0/23",
    "40.80.187.0/24",
    "40.82.252.0/24",
    "40.119.10.0/24",
    "51.104.26.0/24",
    "52.150.138.0/24",
    "52.228.82.0/24",
    "191.235.226.0/24",
    # frontdoor cidr
    "4.232.98.112/29",
    "13.73.248.8/29",
    "13.105.221.0/24",
    "13.107.208.0/24",
    "13.107.213.0/24",
    "13.107.224.0/24",
    "13.107.226.0/24",
    "13.107.231.0/24",
    "13.107.234.0/23",
    "13.107.237.0/24",
    "13.107.238.0/23",
    "13.107.246.0/24",
    "13.107.253.0/24",
    "20.17.125.72/29",
    "20.21.37.32/29",
    "20.36.120.96/29",
    "20.37.64.96/29",
    "20.37.156.112/29",
    "20.37.192.88/29",
    "20.37.224.96/29",
    "20.38.84.64/29",
    "20.38.136.96/29",
    "20.39.11.0/29",
    "20.41.4.80/29",
    "20.41.64.112/29",
    "20.41.192.96/29",
    "20.42.4.112/29",
    "20.42.129.144/29",
    "20.42.224.96/29",
    "20.43.41.128/29",
    "20.43.64.88/29",
    "20.43.128.104/29",
    "20.45.112.96/29",
    "20.45.192.96/29",
    "20.51.7.32/29",
    "20.52.95.240/29",
    "20.59.82.180/30",
    "20.72.18.240/29",
    "20.97.39.120/29",
    "20.113.254.80/29",
    "20.119.28.40/29",
    "20.150.160.72/29",
    "20.189.106.72/29",
    "20.192.161.96/29",
    "20.192.225.40/29",
    "20.210.70.68/30",
    "20.215.4.200/29",
    "20.217.44.200/29",
    "40.67.48.96/29",
    "40.74.30.64/29",
    "40.80.56.96/29",
    "40.80.168.96/29",
    "40.80.184.112/29",
    "40.82.248.72/29",
    "40.89.16.96/29",
    "40.90.64.0/22",
    "40.90.68.0/24",
    "40.90.70.0/23",
    "51.12.41.0/29",
    "51.12.193.0/29",
    "51.53.28.216/29",
    "51.104.24.88/29",
    "51.105.80.96/29",
    "51.105.88.96/29",
    "51.107.48.96/29",
    "51.107.144.96/29",
    "51.120.40.96/29",
    "51.120.224.96/29",
    "51.137.160.88/29",
    "51.143.192.96/29",
    "52.136.48.96/29",
    "52.140.104.96/29",
    "52.150.136.112/29",
    "52.228.80.112/29",
    "68.210.172.152/29",
    "68.221.92.24/29",
    "102.133.56.80/29",
    "102.133.216.80/29",
    "104.212.67.0/24",
    "104.212.68.0/24",
    "150.171.22.0/23",
    "150.171.26.0/24",
    "150.171.84.0/22",
    "150.171.88.0/23",
    "158.23.108.48/29",
    "172.204.165.104/29",
    "191.233.9.112/29",
    "191.235.224.88/29"
  ]
}
