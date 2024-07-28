module "elb" {
  source = "../../"

  # ELB
  elb_name = "test"
  elb_listener_map = {
    "test" = {
      instance_port     = 80
      instance_protocol = "TCP"
      lb_port           = 80
      lb_protocol       = "TCP"
    }
  }
}
