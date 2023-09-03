variable "resource_group_name" {
  description = "The name of your individual resource group name"
  default = "< your variable >"
}

variable "location" {
  description = "The Azure Region for the lab. This can be left default."
  default = "australiaeast"
}

variable "name" {
  description = "Enter your initials here"
  default = "< your variable >"
}

variable "subnet_allocated" {
  description = "enter your subnet according to the subnet allocation chart"
  default = "< your variable >"
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 3
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}