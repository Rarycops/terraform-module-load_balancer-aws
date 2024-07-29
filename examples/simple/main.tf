module "elb" {
  source = "../../"

  # ELB
  load_balancer_type = "elb"
  elb_name           = "test"
  elb_listener_map = {
    "test" = {
      instance_port     = 80
      instance_protocol = "TCP"
      lb_port           = 80
      lb_protocol       = "TCP"
    }
  }
}

module "lb_network" {
  source = "../../"

  # LB
  load_balancer_type    = "lb"
  lb_subnets            = ["test_ntw"]
  lb_load_balancer_type = "network"
  # lb_subnet_mapping = {
  #   "test" = {
  #     allocation_id        = "value"
  #     ipv6_address         = "value"
  #     private_ipv4_address = "value"
  #     subnet_id            = "value"
  #   }
  # }
}

module "lb_application" {
  source = "../../"

  # LB
  load_balancer_type                             = "lb"
  lb_subnets                                     = ["test_appl"]
  lb_load_balancer_type                          = "application"
  lb_enable_cross_zone_load_balancing            = true
  lb_enable_tls_version_and_cipher_suite_headers = true
  # lb_listener_map                                = local.default_lb_listener_map
  lb_listener_forward_map = {
    "name" = {
      alpn_policy     = "value"
      certificate_arn = "value"
      default_action = [{
        forward = [{
          target_group = [{
            arn    = "value"
            weight = 0
          }]
        }]
        order            = 0
        target_group_arn = "arn:aws:lambda:us-west-2:123456789012:function:my-function"
      }]
      mutual_authentication = [{
        ignore_client_certificate_expiry = false
        mode                             = "value"
        trust_store_arn                  = "value"
      }]
      port       = 0
      protocol   = "value"
      ssl_policy = "value"
    }
  }
  # lb_subnet_mapping = {
  #   "test" = {
  #     allocation_id        = "value"
  #     ipv6_address         = "value"
  #     private_ipv4_address = "value"
  #     subnet_id            = "value"
  #   }
  # }
}

output "test_listener" {
  value = module.lb_application.lb_listener_forward
}

output "test_listener2" {
  value = module.lb_application.lb_listener
}

output "test_listener3" {
  value = module.lb_network.lb_listener
}
