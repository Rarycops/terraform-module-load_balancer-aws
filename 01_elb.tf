# Create a new load balancer
resource "aws_elb" "elb" {
  count = var.load_balancer_type == "elb" ? 1 : 0

  name                        = var.elb_name
  availability_zones          = var.elb_subnets == null ? var.elb_availability_zones : null
  security_groups             = var.elb_security_groups
  subnets                     = var.elb_subnets
  instances                   = var.elb_istances
  internal                    = var.elb_internal
  cross_zone_load_balancing   = var.elb_cross_zone_load_balancing
  idle_timeout                = var.elb_idle_timeout
  connection_draining         = var.elb_connection_draining
  connection_draining_timeout = var.elb_connection_draining_timeout
  desync_mitigation_mode      = var.elb_desync_mitigation_mode
  tags                        = merge(var.general_tags, var.elb_tags)
  dynamic "access_logs" {
    for_each = var.elb_access_logs_bucket != null ? [1] : []
    content {
      bucket        = var.elb_access_logs_bucket
      bucket_prefix = var.elb_access_logs_bucket_prefix
      interval      = var.elb_access_logs_interval
      enabled       = var.elb_access_logs_enabled
    }
  }
  dynamic "listener" {
    for_each = var.elb_listener_map
    content {
      instance_port     = listener.value.instance_port
      instance_protocol = listener.value.instance_protocol
      lb_port           = listener.value.lb_port
      lb_protocol       = listener.value.lb_protocol
    }
  }
  dynamic "health_check" {
    for_each = (
      var.elb_health_check_healthy_threshold != null &&
      var.elb_health_check_interval != null &&
      var.elb_health_check_target != null &&
      var.elb_health_check_unhealthy_threshold != null &&
      var.elb_health_check_timeout != null
    ) ? [1] : []
    content {
      healthy_threshold   = var.elb_health_check_healthy_threshold
      interval            = var.elb_health_check_interval
      target              = var.elb_health_check_target
      timeout             = var.elb_health_check_timeout
      unhealthy_threshold = var.elb_health_check_unhealthy_threshold
    }
  }
}
