variable "location" {
  description = "(Optional) The location/region where the load balancer will be created. If not provided, will use the location of the resource group."
  default = ""
}

variable "resource_group_name" {
  description = "(Required) The name of the existing resource group where the load balancer resources will be placed."
}

variable "prefix" {
  description = "(Required) Default prefix to use with your resource names."
}

variable "remote_port" {
  description = "Protocols to be used for remote vm access. [protocol, backend_port].  Frontend port will be automatically generated starting at 50000 and in the output."
  default     = {}
}

variable "lb_port" {
  description = "Protocols to be used for lb health probes and rules. [frontend_port, protocol, backend_port]"
  default     = {}
}

variable "lb_probe_unhealthy_threshold" {
  description = "Number of times the load balancer health probe has an unsuccessful attempt before considering the endpoint unhealthy."
  default     = 2
}

variable "lb_probe_interval" {
  description = "Interval in seconds the load balancer health probe rule does a check"
  default     = 5
}

variable "frontend_name" {
  description = "(Optional) Specifies the name of the frontend ip configuration."
  default = "FrontendIP"
}

variable "public_ip_address_allocation" {
  description = "(Optional) Defines how an IP address is assigned. Options are Static or Dynamic. Default static."
  default     = "static"
}

variable "tags" {
  type = "map"
  description = "(optional) Tags to use in addition to tags assigned to the resource group."

  default = {
    source = "terraform"
  }
}

variable "type" {
  type        = "string"
  description = "(Optional) Defined if the loadbalancer is private or public. Default private."
  default     = "private"
}

variable "subnet_id" {
  description = "(Optional) Frontend subnet id to use when in private mode"
  default     = ""
}

variable "private_ip_address" {
  description = "(Optional) Private ip address to assign to frontend. Use it with type = private"
  default     = ""
}

