variable "lb_access_logs_bucket" {
  description = "The S3 bucket name to store the logs in."
  type        = string
  default     = null
}

variable "lb_access_logs_prefix" {
  description = "The S3 bucket prefix. Logs are stored in the root if not configured."
  type        = string
  default     = null
  validation {
    condition     = (var.lb_access_logs_bucket != null && var.lb_access_logs_prefix != null) || var.lb_access_logs_prefix == null
    error_message = "lb_access_logs_bucket must be set for this variable to be used"
  }
}

variable "lb_access_logs_enabled" {
  description = "Boolean to enable / disable access_logs."
  type        = bool
  default     = false
  validation {
    condition     = (var.lb_access_logs_bucket != null && (var.lb_access_logs_enabled == true || var.lb_access_logs_enabled == false)) || var.lb_access_logs_enabled == false
    error_message = "lb_access_logs_bucket must be set for this variable to be used"
  }
}

variable "lb_connection_logs_bucket" {
  description = "The S3 bucket name to store the logs in."
  type        = string
  default     = null
}

variable "lb_connection_logs_prefix" {
  description = "The S3 bucket prefix. Logs are stored in the root if not configured."
  type        = string
  default     = null
  validation {
    condition     = (var.lb_connection_logs_bucket != null && var.lb_connection_logs_prefix != null) || var.lb_connection_logs_prefix == null
    error_message = "lb_connection_logs_bucket must be set for this variable to be used"
  }
}

variable "lb_connection_logs_enabled" {
  description = "Boolean to enable / disable connection_logs."
  type        = bool
  default     = false
  validation {
    condition     = (var.lb_connection_logs_bucket != null && (var.lb_connection_logs_enabled == true || var.lb_connection_logs_enabled == false)) || var.lb_connection_logs_enabled == false
    error_message = "lb_connection_logs_bucket must be set for this variable to be used"
  }
}

variable "lb_client_keep_alive" {
  description = "Client keep alive value in seconds. The valid range is 60-604800 seconds. The default is 3600 seconds."
  type        = number
  default     = 3600
  validation {
    condition     = (var.lb_client_keep_alive >= 60 && var.lb_client_keep_alive <= 604800) || var.lb_client_keep_alive == null
    error_message = "The client keep alive value must be between 60 and 604800 seconds."
  }
}

variable "lb_customer_owned_ipv4_pool" {
  description = "ID of the customer owned ipv4 pool to use for this load balancer."
  type        = string
  default     = null
}

variable "lb_desync_mitigation_mode" {
  description = "How the load balancer handles requests that might pose a security risk to an application due to HTTP desync. Valid values are monitor, defensive (default), strictest."
  type        = string
  default     = "defensive"
  validation {
    condition     = var.lb_desync_mitigation_mode == null || var.lb_desync_mitigation_mode == "monitor" || var.lb_desync_mitigation_mode == "defensive" || var.lb_desync_mitigation_mode == "strictest"
    error_message = "The desync mitigation mode must be one of the following: monitor, defensive, strictest."
  }
}

variable "lb_load_balancer_type" {
  description = "Type of load balancer to create. Possible values are application, gateway, or network. The default value is application."
  type        = string
  default     = "application"
  validation {
    condition     = var.lb_load_balancer_type == "application" || var.lb_load_balancer_type == "gateway" || var.lb_load_balancer_type == "network"
    error_message = "The load balancer type must be one of the following: application, gateway, network."
  }
}

variable "lb_dns_record_client_routing_policy" {
  description = "How traffic is distributed among the load balancer Availability Zones."
  type        = string
  default     = null
  validation {
    condition     = ((var.lb_load_balancer_type == "any_availability_zone" || var.lb_load_balancer_type == "availability_zone_affinity" || var.lb_load_balancer_type == "partial_availability_zone_affinity") && var.lb_load_balancer_type == "network") || var.lb_dns_record_client_routing_policy == null
    error_message = " Possible values are any_availability_zone, availability_zone_affinity, or partial_availability_zone_affinity. Only valid for network type load balancers."
  }
}

variable "lb_subnets" {
  description = "List of subnet IDs to attach to the LB."
  type        = list(string)
  default     = null
  validation {
    condition     = (var.load_balancer_type == "lb" && var.lb_subnets != null) || var.lb_subnets == null
    error_message = "If load_balancer_type is set to lb lb_subnets should be set"
  }
}

variable "lb_subnet_mapping" {
  description = "Subnet mapping block."
  type = map(object({
    subnet_id            = string
    allocation_id        = string
    ipv6_address         = string
    private_ipv4_address = string
  }))
  default = null
  validation {
    condition     = (var.load_balancer_type == "lb" && var.lb_load_balancer_type == "network" && var.lb_subnets == null && var.lb_subnet_mapping != null) || var.lb_subnet_mapping == null
    error_message = "If load_balancer_type is set to lb and lb_subnets is not set, lb_subnet_mapping should be set"
  }
}

variable "lb_drop_invalid_header_fields" {
  description = "Whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). Only valid for Load Balancers of type application."
  type        = bool
  default     = false
}

variable "lb_enable_cross_zone_load_balancing" {
  description = "If true, cross-zone load balancing of the load balancer will be enabled. For application load balancer this feature is always enabled (true) and cannot be disabled."
  type        = bool
  default     = false
}

variable "lb_enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer."
  type        = bool
  default     = false
}

variable "lb_enable_http2" {
  description = "Whether HTTP/2 is enabled in application load balancers."
  type        = bool
  default     = true
}

variable "lb_enable_tls_version_and_cipher_suite_headers" {
  description = "Whether the two headers (x-amzn-tls-version and x-amzn-tls-cipher-suite), which contain information about the negotiated TLS version and cipher suite, are added to the client request before sending it to the target."
  type        = bool
  default     = false
}

variable "lb_enable_xff_client_port" {
  description = "Whether the X-Forwarded-For header should preserve the source port that the client used to connect to the load balancer in application load balancers."
  type        = bool
  default     = false
}

variable "lb_enable_waf_fail_open" {
  description = "Whether to allow a WAF-enabled load balancer to route requests to targets if it is unable to forward the request to AWS WAF."
  type        = bool
  default     = false
}

variable "lb_enforce_security_group_inbound_rules_on_private_link_traffic" {
  description = "Whether inbound security group rules are enforced for traffic originating from a PrivateLink. Only valid for Load Balancers of type network."
  type        = string
  default     = null
  validation {
    condition     = (var.lb_load_balancer_type == "network" && (var.lb_enforce_security_group_inbound_rules_on_private_link_traffic == "on" || var.lb_enforce_security_group_inbound_rules_on_private_link_traffic == "off")) || var.lb_enforce_security_group_inbound_rules_on_private_link_traffic == null
    error_message = "value"
  }
}

variable "lb_idle_timeout" {
  description = "Time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application."
  type        = number
  default     = 60
}

variable "lb_internal" {
  description = "If true, the LB will be internal."
  type        = bool
  default     = false
}

variable "lb_ip_address_type" {
  description = "Type of IP addresses used by the subnets for your load balancer."
  type        = string
  default     = null
  validation {
    condition     = var.lb_ip_address_type == null || var.lb_ip_address_type == "ipv4" || var.lb_ip_address_type == "dualstack" || (var.lb_load_balancer_type == "application" && var.lb_ip_address_type == "dualstack-without-public-ipv4")
    error_message = "The possible values depend upon the load balancer type: ipv4 (all load balancer types), dualstack (all load balancer types), and dualstack-without-public-ipv4 (type application only)."
  }
}

variable "lb_name" {
  description = "Name of the LB."
  type        = string
  default     = null
  validation {
    condition     = var.lb_name == null || can(length(var.lb_name) <= 32 && can(regex("^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*$", var.lb_name)))
    error_message = "The name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen."
  }
}

variable "lb_security_groups" {
  description = "List of security group IDs to assign to the LB."
  type        = list(string)
  default     = null
  validation {
    condition     = ((var.lb_load_balancer_type == "application" || var.lb_load_balancer_type == "network") && var.lb_security_groups != null) || var.lb_security_groups == null
    error_message = "Only valid for Load Balancers of type application or network."
  }
}

variable "lb_preserve_host_header" {
  description = "Whether the Application Load Balancer should preserve the Host header in the HTTP request and send it to the target without any change."
  type        = bool
  default     = false
}

variable "lb_tags" {
  description = "Map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = {}
}

variable "lb_xff_header_processing_mode" {
  description = "Determines how the load balancer modifies the X-Forwarded-For header in the HTTP request before sending the request to the target."
  type        = string
  default     = "append"
  validation {
    condition     = (var.lb_load_balancer_type == "application" && (var.lb_xff_header_processing_mode == "preserve" || var.lb_xff_header_processing_mode == "remove")) || var.lb_xff_header_processing_mode == "append"
    error_message = "Only valid for Load Balancers of type application or network."
  }
}

variable "lb_listener_map" {
  description = "Map for the listener variables. If the variable is not use keep the default"
  type = map(object({
    alpn_policy     = string
    certificate_arn = string
    port            = number
    protocol        = string
    ssl_policy      = string
    mutual_authentication = list(object({
      mode                             = string
      trust_store_arn                  = string
      ignore_client_certificate_expiry = bool
    }))
    default_action = list(object({
      type             = string
      order            = number
      target_group_arn = string
      authenticate_cognito = list(object({
        user_pool_arn                       = string
        user_pool_client_id                 = string
        user_pool_domain                    = string
        authentication_request_extra_params = map(string)
        on_unauthenticated_request          = string
        scope                               = string
        session_cookie_name                 = string
        session_timeout                     = number
      }))
      authenticate_oidc = list(object({
        authorization_endpoint              = string
        client_id                           = string
        client_secret                       = string
        issuer                              = string
        token_endpoint                      = string
        user_info_endpoint                  = string
        authentication_request_extra_params = map(string)
        on_unauthenticated_request          = string
        scope                               = string
        session_cookie_name                 = string
        session_timeout                     = number
      }))
      fixed_response = list(object({
        content_type = string
        message_body = string
        status_code  = string
      }))
      forward = list(object({
        target_group = list(object({
          arn    = string
          weight = number
        }))
        stickiness = list(object({
          duration = number
          enabled  = bool
        }))
      }))
      redirect = list(object({
        status_code = string
        host        = string
        path        = string
        port        = string
        protocol    = string
        query       = string
      }))
    }))
  }))
  default = {}
}

variable "lb_listener_forward_map" {
  description = "Map for the listener variables for fordward listeners. This is a way to make listeners maps more manageable. If the variable is not use keep the default"
  type = map(object({
    alpn_policy     = string
    certificate_arn = string
    port            = number
    protocol        = string
    ssl_policy      = string
    mutual_authentication = list(object({
      mode                             = string
      trust_store_arn                  = string
      ignore_client_certificate_expiry = bool
    }))
    default_action = list(object({
      order            = number
      target_group_arn = string
      forward = list(object({
        target_group = list(object({
          arn    = string
          weight = number
        }))
        stickiness = list(object({
          duration = number
          enabled  = bool
        }))
      }))
    }))
  }))
  default = {}
}

variable "lb_listener_redirect_map" {
  description = "Map for the listener variables for redirect listeners. This is a way to make listeners maps more manageable. If the variable is not use keep the default"
  type = map(object({
    alpn_policy     = string
    certificate_arn = string
    port            = number
    protocol        = string
    ssl_policy      = string
    mutual_authentication = list(object({
      mode                             = string
      trust_store_arn                  = string
      ignore_client_certificate_expiry = bool
    }))
    default_action = list(object({
      order = number
      redirect = list(object({
        status_code = string
        host        = string
        path        = string
        port        = string
        protocol    = string
        query       = string
      }))
    }))
  }))
  default = {}
}

variable "lb_listener_fixed_response_map" {
  description = "Map for the listener variables for fixed response listeners. This is a way to make listeners maps more manageable. If the variable is not use keep the default"
  type = map(object({
    alpn_policy     = string
    certificate_arn = string
    port            = number
    protocol        = string
    ssl_policy      = string
    mutual_authentication = list(object({
      mode                             = string
      trust_store_arn                  = string
      ignore_client_certificate_expiry = bool
    }))
    default_action = list(object({
      order = number
      fixed_response = list(object({
        content_type = string
        message_body = string
        status_code  = string
      }))
    }))
  }))
  default = {}
}

variable "lb_listener_authenticate_oidc_map" {
  description = "Map for the listener variables for authenticate oicd listeners. This is a way to make listeners maps more manageable. If the variable is not use keep the default"
  type = map(object({
    alpn_policy     = string
    certificate_arn = string
    port            = number
    protocol        = string
    ssl_policy      = string
    mutual_authentication = list(object({
      mode                             = string
      trust_store_arn                  = string
      ignore_client_certificate_expiry = bool
    }))
    default_action = list(object({
      order = number
      authenticate_oidc = list(object({
        authorization_endpoint              = string
        client_id                           = string
        client_secret                       = string
        issuer                              = string
        token_endpoint                      = string
        user_info_endpoint                  = string
        authentication_request_extra_params = map(string)
        on_unauthenticated_request          = string
        scope                               = string
        session_cookie_name                 = string
        session_timeout                     = number
      }))
    }))
  }))
  default = {}
}

variable "lb_listener_authenticate_cognito_map" {
  description = "Map for the listener variables for authenticate cognito listeners. This is a way to make listeners maps more manageable. If the variable is not use keep the default"
  type = map(object({
    alpn_policy     = string
    certificate_arn = string
    port            = number
    protocol        = string
    ssl_policy      = string
    mutual_authentication = list(object({
      mode                             = string
      trust_store_arn                  = string
      ignore_client_certificate_expiry = bool
    }))
    default_action = list(object({
      order = number
      authenticate_cognito = list(object({
        user_pool_arn                       = string
        user_pool_client_id                 = string
        user_pool_domain                    = string
        authentication_request_extra_params = map(string)
        on_unauthenticated_request          = string
        scope                               = string
        session_cookie_name                 = string
        session_timeout                     = number
      }))
    }))
  }))
  default = {}
}

variable "lb_listener_tags" {
  description = "A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = {}
}

variable "lb_target_group_map" {
  description = "Map for the lb target group. default value is the same as null."
  type = map(object({
    connection_termination                                     = bool
    deregistration_delay                                       = string
    target_type                                                = string
    lambda_multi_value_headers_enabled                         = bool
    load_balancing_algorithm_type                              = string
    load_balancing_anomaly_mitigation                          = string
    load_balancing_cross_zone_enabled                          = string
    name                                                       = string
    port                                                       = number
    protocol                                                   = string
    vpc_id                                                     = string
    preserve_client_ip                                         = string
    protocol_version                                           = string
    proxy_protocol_v2                                          = bool
    slow_start                                                 = number
    target_failover                                            = string
    enable_unhealthy_connection_termination                    = string
    dns_failover_minimum_healthy_targets_count                 = string
    dns_failover_minimum_healthy_targets_percentage            = string
    unhealthy_state_routing_minimum_healthy_targets_count      = number
    unhealthy_state_routing_minimum_healthy_targets_percentage = string
    health_check = list(object({
      enabled             = bool
      healthy_threshold   = number
      interval            = number
      matcher             = string
      path                = string
      port                = string
      protocol            = string
      timeout             = number
      unhealthy_threshold = number
    }))
    stickiness = list(object({
      type            = string
      cookie_duration = number
      cookie_name     = string
      enabled         = bool
    }))
  }))
  default = {}
}

variable "lb_target_group_tags" {
  description = "Tags for the lb target group"
  type        = map(string)
  default     = {}
}
