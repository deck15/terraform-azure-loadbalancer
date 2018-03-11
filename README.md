Azure Load Balancer Terraform Module
==========

A terraform module to provide load balancers in Azure.

Public or Private load balancer. Works for Azure Public and Private clouds.

Usage
-----
Public loadbalancer example:

```hcl
resource "azurerm_resource_group" "rg" {
  name = "${var.resource_group_name}"
  location = "westus"

  tags = {
    environment = "nonprod"
    costcenter  = "12345"
    appname     = "myapp"
  }
}

module "mylb" {
  source  = "github.com/highwayoflife/terraform-azure-loadbalancer"
  type    = "Public"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  prefix              = "terraform-test"

  "remote_port" {
    ssh = ["Tcp", "22"]
  }

  "lb_port" {
    http = ["443", "Tcp", "443"]
  }
}
```

Private loadbalancer example:

```hcl
resource "azurerm_resource_group" "rg" {
  name = "${var.resource_group_name}"
  location = "westus"

  tags = {
    environment = "nonprod"
    costcenter  = "12345"
    appname     = "myapp"
  }
}

data "azurerm_subnet" "subnet" {
  name                  = "${var.subnet_name}"
  virtual_network_name  = "${var.vnet_name}"
  resource_group_name   = "${var.vnet_resource_group_name}"
}

module "mylb" {
  source  = "github.com/highwayoflife/terraform-azure-loadbalancer"
  type    = "private"
  prefix  = "MyTerraformLB"
  resource_group_name           = "${azurerm_resource_group.rg.name}"
  subnet_id                     = "${data.azurerm_subnet.subnet.id}"
  # Define a static IP, if empty or not defined, IP will be dynamic
  private_ip_address            = "10.0.1.6"

  "remote_port" {
    ssh = ["Tcp", "22"]
  }

  "lb_port" {
    https = ["443", "Tcp", "443"]
  }
}
```


Argument Reference
--------
The following arguments are supported:

* `location`
  * (Optional) The location/region where the load balancer will be created. If not provided, will use the location of the resource group.
* `resource_group_name`
  * (Required) The name of the existing resource group where the load balancer resources will be placed.
* `prefix`
  * (Required) Default prefix to use with your resource names.
* `remote_port`
  * Protocols to be used for remote vm access. [protocol, backend\_port].  Frontend port will be automatically generated starting at 50000 and in the output.
* `lb_port`
  * Protocols to be used for lb health probes and rules. [frontend\_port, protocol, backend\_port]
* `lb_probe_unhealthy_threshold`
  * (Optional) Number of times the load balancer health probe has an unsuccessful attempt before considering the endpoint unhealthy. default = 2
* `lb_probe_interval`
  * (Optional) Interval in seconds the load balancer health probe rule does a check. default = 5
* `frontend_name`
  * (Optional) Specifies the name of the frontend ip configuration. default = "FrontendIP"
* `public_ip_address_allocation`
  * (Optional) Defines now an IP address is assigned. Options are Static or Dynamic. Default = static.
* `tags`
  * (Optional) Map of tags in addition to tags assigned to the resource group.
* `type`
  * (Optional) Defined if the loadbalancer is private or public. Default private.
* `subnet_id`
  * (Optional) Frotend subnet id to use when in private mode.
* `private_ip_address`
  * (Optional) Private ip address to assign to frontend. Use with type = private.
* `private_ip_address_allocation`
  * (Optional) Frotend ip allocation type (Static or Dynamic). Default Dynamic.

Attribute Reference
-------
The following attributes are exported:

* `lb_id`
  * The id for the azurerm\_lb resource.
* `lb_frontend_ip_configuration`
  * The frontend\_ip\_configuration for the azurerm\_lb resource
* `lb_probe_ids`
  * The ids for the azurerm\_lb\_probe resources.
* `lb_nat_rule_ids`
  * The ids for the azurerm\_lb\_nat\_rule resources.
* `public_ip_id`
  * The id for the azurerm\_lb\_public\_ip\_resource.
* `public_ip_address`
  * The ip address for the azurerm\_lb\_public\_ip resource.
* `lb_backend_address_pool_id`
  * The id for the azurerm\_lb\_backend\_address\_pool resource
* `lb_private_ip_address`
  * The first private IP address assigned to the load balancer in frontend\_ip\_configuration blocks, if any.

Contributors
-----

* [David Lewis](https://github.com/highwayoflife)

License
------

[MIT](LICENSE)

