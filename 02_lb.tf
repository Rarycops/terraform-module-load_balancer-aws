resource "aws_lb" "lb" {
  count = var.load_balancer_type == "lb" ? 1 : 0

  name                                                         = var.lb_name
  client_keep_alive                                            = var.lb_client_keep_alive
  customer_owned_ipv4_pool                                     = var.lb_customer_owned_ipv4_pool
  desync_mitigation_mode                                       = var.lb_desync_mitigation_mode
  load_balancer_type                                           = var.lb_load_balancer_type
  dns_record_client_routing_policy                             = var.lb_dns_record_client_routing_policy
  subnets                                                      = var.lb_subnets
  drop_invalid_header_fields                                   = var.lb_drop_invalid_header_fields
  enable_cross_zone_load_balancing                             = var.lb_load_balancer_type == "application" ? true : var.lb_enable_cross_zone_load_balancing
  enable_deletion_protection                                   = var.lb_enable_deletion_protection
  enable_http2                                                 = var.lb_enable_http2
  enable_tls_version_and_cipher_suite_headers                  = var.lb_enable_tls_version_and_cipher_suite_headers
  enable_xff_client_port                                       = var.lb_enable_xff_client_port
  enable_waf_fail_open                                         = var.lb_enable_waf_fail_open
  enforce_security_group_inbound_rules_on_private_link_traffic = var.lb_enforce_security_group_inbound_rules_on_private_link_traffic
  idle_timeout                                                 = var.lb_idle_timeout
  internal                                                     = var.lb_internal
  ip_address_type                                              = var.lb_ip_address_type
  security_groups                                              = var.lb_security_groups
  preserve_host_header                                         = var.lb_preserve_host_header
  tags                                                         = merge(var.general_tags, var.lb_tags)
  xff_header_processing_mode                                   = var.lb_xff_header_processing_mode
  dynamic "access_logs" {
    for_each = var.lb_access_logs_bucket != null ? [1] : []
    content {
      bucket  = var.lb_access_logs_bucket
      prefix  = var.lb_access_logs_prefix
      enabled = var.lb_access_logs_enabled
    }
  }
  dynamic "connection_logs" {
    for_each = var.lb_connection_logs_bucket != null ? [1] : []
    content {
      bucket  = var.lb_connection_logs_bucket
      prefix  = var.lb_connection_logs_prefix
      enabled = var.lb_connection_logs_enabled
    }
  }
  dynamic "subnet_mapping" {
    for_each = var.lb_subnet_mapping != null && var.lb_subnets == null ? var.lb_subnet_mapping : {}
    content {
      subnet_id            = subnet_mapping.value.subnet_id
      allocation_id        = subnet_mapping.value.allocation_id
      ipv6_address         = subnet_mapping.value.ipv6_address
      private_ipv4_address = subnet_mapping.value.private_ipv4_address
    }
  }
}

resource "aws_lb_listener" "lb_listener" {
  depends_on = [aws_lb.lb]
  for_each   = var.lb_listener_map

  load_balancer_arn = aws_lb.lb[0].arn
  alpn_policy       = each.value.alpn_policy == "value" ? null : each.value.alpn_policy
  certificate_arn   = each.value.certificate_arn == "value" ? null : each.value.certificate_arn
  port              = each.value.port == 0 ? null : each.value.port
  protocol          = each.value.protocol == "value" ? null : each.value.protocol
  ssl_policy        = each.value.ssl_policy == "value" ? null : each.value.ssl_policy
  tags              = merge(var.general_tags, var.lb_listener_tags)
  dynamic "mutual_authentication" {
    for_each = each.value.mutual_authentication[0].mode != "value" && each.value.mutual_authentication[0].trust_store_arn != "value" ? [1] : []
    content {
      mode                             = each.value.mutual_authentication[0].mode
      trust_store_arn                  = each.value.mutual_authentication[0].trust_store_arn
      ignore_client_certificate_expiry = each.value.mutual_authentication[0].ignore_client_certificate_expiry
    }
  }
  default_action {
    type             = each.value.default_action[0].type == "value" ? null : each.value.default_action[0].type
    order            = each.value.default_action[0].order == 0 ? null : each.value.default_action[0].order
    target_group_arn = each.value.default_action[0].target_group_arn == "value" ? null : each.value.default_action[0].target_group_arn
    dynamic "authenticate_cognito" {
      for_each = ((
        each.value.default_action[0].authenticate_cognito[0].user_pool_arn != "value") && (
        each.value.default_action[0].authenticate_cognito[0].user_pool_client_id != "value") && (
        each.value.default_action[0].authenticate_cognito[0].user_pool_domain != "value"
      )) ? [1] : []
      content {
        user_pool_arn                       = each.value.default_action[0].authenticate_cognito[0].user_pool_arn
        user_pool_client_id                 = each.value.default_action[0].authenticate_cognito[0].user_pool_client_id
        user_pool_domain                    = each.value.default_action[0].authenticate_cognito[0].user_pool_domain
        authentication_request_extra_params = each.value.default_action[0].authenticate_cognito[0].authentication_request_extra_params
        on_unauthenticated_request          = each.value.default_action[0].authenticate_cognito[0].on_unauthenticated_request
        scope                               = each.value.default_action[0].authenticate_cognito[0].scope
        session_cookie_name                 = each.value.default_action[0].authenticate_cognito[0].session_cookie_name
        session_timeout                     = each.value.default_action[0].authenticate_cognito[0].session_timeout
      }
    }
    dynamic "authenticate_oidc" {
      for_each = ((
        each.value.default_action[0].authenticate_oidc[0].authorization_endpoint != "value") && (
        each.value.default_action[0].authenticate_oidc[0].client_id != "value") && (
        each.value.default_action[0].authenticate_oidc[0].client_secret != "value") && (
        each.value.default_action[0].authenticate_oidc[0].issuer != "value") && (
        each.value.default_action[0].authenticate_oidc[0].token_endpoint != "value") && (
        each.value.default_action[0].authenticate_oidc[0].user_info_endpoint != "value"
      )) ? [1] : []
      content {
        authorization_endpoint              = each.value.default_action[0].authenticate_oidc[0].authorization_endpoint
        client_id                           = each.value.default_action[0].authenticate_oidc[0].client_id
        client_secret                       = each.value.default_action[0].authenticate_oidc[0].client_secret
        issuer                              = each.value.default_action[0].authenticate_oidc[0].issuer
        token_endpoint                      = each.value.default_action[0].authenticate_oidc[0].token_endpoint
        user_info_endpoint                  = each.value.default_action[0].authenticate_oidc[0].user_info_endpoint
        authentication_request_extra_params = each.value.default_action[0].authenticate_oidc[0].authentication_request_extra_params
        on_unauthenticated_request          = each.value.default_action[0].authenticate_oidc[0].on_unauthenticated_request
        scope                               = each.value.default_action[0].authenticate_oidc[0].scope
        session_cookie_name                 = each.value.default_action[0].authenticate_oidc[0].session_cookie_name
        session_timeout                     = each.value.default_action[0].authenticate_oidc[0].session_timeout
      }
    }
    dynamic "fixed_response" {
      for_each = each.value.default_action[0].fixed_response[0].content_type != "value" ? [1] : []
      content {
        content_type = each.value.default_action[0].fixed_response[0].content_type
        message_body = each.value.default_action[0].fixed_response[0].message_body
        status_code  = each.value.default_action[0].fixed_response[0].status_code
      }
    }
    dynamic "forward" {
      for_each = each.value.default_action[0].forward[0].target_group[0].arn != "value" ? each.value.default_action[0].forward : []
      content {
        dynamic "target_group" {
          for_each = forward.value.target_group[0].arn != "value" ? [1] : []
          content {
            arn    = forward.value.target_group[0].arn
            weight = forward.value.target_group[0].weight
          }
        }
      }
    }
    dynamic "redirect" {
      for_each = each.value.default_action[0].redirect[0].status_code != "value" ? [1] : []
      content {
        status_code = each.value.default_action[0].redirect[0].status_code
        host        = each.value.default_action[0].redirect[0].host
        path        = each.value.default_action[0].redirect[0].path
        port        = each.value.default_action[0].redirect[0].port
        protocol    = each.value.default_action[0].redirect[0].protocol
        query       = each.value.default_action[0].redirect[0].query
      }
    }
  }
}

resource "aws_lb_listener" "lb_listener_forward" {
  depends_on = [aws_lb.lb]
  for_each   = var.lb_listener_forward_map

  load_balancer_arn = aws_lb.lb[0].arn
  alpn_policy       = each.value.alpn_policy == "value" ? null : each.value.alpn_policy
  certificate_arn   = each.value.certificate_arn == "value" ? null : each.value.certificate_arn
  port              = each.value.port == 0 ? null : each.value.port
  protocol          = each.value.protocol == "value" ? null : each.value.protocol
  ssl_policy        = each.value.ssl_policy == "value" ? null : each.value.ssl_policy
  tags              = merge(var.general_tags, var.lb_listener_tags)
  dynamic "mutual_authentication" {
    for_each = each.value.mutual_authentication[0].mode != "value" && each.value.mutual_authentication[0].trust_store_arn != "value" ? [1] : []
    content {
      mode                             = each.value.mutual_authentication[0].mode
      trust_store_arn                  = each.value.mutual_authentication[0].trust_store_arn
      ignore_client_certificate_expiry = each.value.mutual_authentication[0].ignore_client_certificate_expiry
    }
  }
  default_action {
    type             = "forward"
    order            = each.value.default_action[0].order == 0 ? null : each.value.default_action[0].order
    target_group_arn = each.value.default_action[0].target_group_arn == "value" ? null : each.value.default_action[0].target_group_arn
    dynamic "forward" {
      for_each = each.value.default_action[0].forward[0].target_group[0].arn != "value" ? each.value.default_action[0].forward : []
      content {
        dynamic "target_group" {
          for_each = forward.value.target_group[0].arn != "value" ? [1] : []
          content {
            arn    = forward.value.target_group[0].arn
            weight = forward.value.target_group[0].weight
          }
        }
      }
    }
  }
}

resource "aws_lb_listener" "lb_listener_redirect" {
  depends_on = [aws_lb.lb]
  for_each   = var.lb_listener_redirect_map

  load_balancer_arn = aws_lb.lb[0].arn
  alpn_policy       = each.value.alpn_policy == "value" ? null : each.value.alpn_policy
  certificate_arn   = each.value.certificate_arn == "value" ? null : each.value.certificate_arn
  port              = each.value.port == 0 ? null : each.value.port
  protocol          = each.value.protocol == "value" ? null : each.value.protocol
  ssl_policy        = each.value.ssl_policy == "value" ? null : each.value.ssl_policy
  tags              = merge(var.general_tags, var.lb_listener_tags)
  dynamic "mutual_authentication" {
    for_each = each.value.mutual_authentication[0].mode != "value" && each.value.mutual_authentication[0].trust_store_arn != "value" ? [1] : []
    content {
      mode                             = each.value.mutual_authentication[0].mode
      trust_store_arn                  = each.value.mutual_authentication[0].trust_store_arn
      ignore_client_certificate_expiry = each.value.mutual_authentication[0].ignore_client_certificate_expiry
    }
  }
  default_action {
    type  = "redirect"
    order = each.value.default_action[0].order == 0 ? null : each.value.default_action[0].order
    dynamic "redirect" {
      for_each = each.value.default_action[0].redirect[0].status_code != "value" ? [1] : []
      content {
        status_code = each.value.default_action[0].redirect[0].status_code
        host        = each.value.default_action[0].redirect[0].host
        path        = each.value.default_action[0].redirect[0].path
        port        = each.value.default_action[0].redirect[0].port
        protocol    = each.value.default_action[0].redirect[0].protocol
        query       = each.value.default_action[0].redirect[0].query
      }
    }
  }
}

resource "aws_lb_listener" "lb_listener_fixed_response" {
  depends_on = [aws_lb.lb]
  for_each   = var.lb_listener_fixed_response_map

  load_balancer_arn = aws_lb.lb[0].arn
  alpn_policy       = each.value.alpn_policy == "value" ? null : each.value.alpn_policy
  certificate_arn   = each.value.certificate_arn == "value" ? null : each.value.certificate_arn
  port              = each.value.port == 0 ? null : each.value.port
  protocol          = each.value.protocol == "value" ? null : each.value.protocol
  ssl_policy        = each.value.ssl_policy == "value" ? null : each.value.ssl_policy
  tags              = merge(var.general_tags, var.lb_listener_tags)
  dynamic "mutual_authentication" {
    for_each = each.value.mutual_authentication[0].mode != "value" && each.value.mutual_authentication[0].trust_store_arn != "value" ? [1] : []
    content {
      mode                             = each.value.mutual_authentication[0].mode
      trust_store_arn                  = each.value.mutual_authentication[0].trust_store_arn
      ignore_client_certificate_expiry = each.value.mutual_authentication[0].ignore_client_certificate_expiry
    }
  }
  default_action {
    type  = "fixed_response"
    order = each.value.default_action[0].order == 0 ? null : each.value.default_action[0].order
    dynamic "fixed_response" {
      for_each = each.value.default_action[0].fixed_response[0].content_type != "value" ? [1] : []
      content {
        content_type = each.value.default_action[0].fixed_response[0].content_type
        message_body = each.value.default_action[0].fixed_response[0].message_body
        status_code  = each.value.default_action[0].fixed_response[0].status_code
      }
    }
  }
}

resource "aws_lb_listener" "lb_listener_authenticate_oidc" {
  depends_on = [aws_lb.lb]
  for_each   = var.lb_listener_authenticate_oidc_map

  load_balancer_arn = aws_lb.lb[0].arn
  alpn_policy       = each.value.alpn_policy == "value" ? null : each.value.alpn_policy
  certificate_arn   = each.value.certificate_arn == "value" ? null : each.value.certificate_arn
  port              = each.value.port == 0 ? null : each.value.port
  protocol          = each.value.protocol == "value" ? null : each.value.protocol
  ssl_policy        = each.value.ssl_policy == "value" ? null : each.value.ssl_policy
  tags              = merge(var.general_tags, var.lb_listener_tags)
  dynamic "mutual_authentication" {
    for_each = each.value.mutual_authentication[0].mode != "value" && each.value.mutual_authentication[0].trust_store_arn != "value" ? [1] : []
    content {
      mode                             = each.value.mutual_authentication[0].mode
      trust_store_arn                  = each.value.mutual_authentication[0].trust_store_arn
      ignore_client_certificate_expiry = each.value.mutual_authentication[0].ignore_client_certificate_expiry
    }
  }
  default_action {
    type  = "authenticate_oidc"
    order = each.value.default_action[0].order == 0 ? null : each.value.default_action[0].order
    dynamic "authenticate_oidc" {
      for_each = ((
        each.value.default_action[0].authenticate_oidc[0].authorization_endpoint != "value") && (
        each.value.default_action[0].authenticate_oidc[0].client_id != "value") && (
        each.value.default_action[0].authenticate_oidc[0].client_secret != "value") && (
        each.value.default_action[0].authenticate_oidc[0].issuer != "value") && (
        each.value.default_action[0].authenticate_oidc[0].token_endpoint != "value") && (
        each.value.default_action[0].authenticate_oidc[0].user_info_endpoint != "value"
      )) ? [1] : []
      content {
        authorization_endpoint              = each.value.default_action[0].authenticate_oidc[0].authorization_endpoint
        client_id                           = each.value.default_action[0].authenticate_oidc[0].client_id
        client_secret                       = each.value.default_action[0].authenticate_oidc[0].client_secret
        issuer                              = each.value.default_action[0].authenticate_oidc[0].issuer
        token_endpoint                      = each.value.default_action[0].authenticate_oidc[0].token_endpoint
        user_info_endpoint                  = each.value.default_action[0].authenticate_oidc[0].user_info_endpoint
        authentication_request_extra_params = each.value.default_action[0].authenticate_oidc[0].authentication_request_extra_params
        on_unauthenticated_request          = each.value.default_action[0].authenticate_oidc[0].on_unauthenticated_request
        scope                               = each.value.default_action[0].authenticate_oidc[0].scope
        session_cookie_name                 = each.value.default_action[0].authenticate_oidc[0].session_cookie_name
        session_timeout                     = each.value.default_action[0].authenticate_oidc[0].session_timeout
      }
    }
  }
}

resource "aws_lb_listener" "lb_listener_authenticate_cognito" {
  depends_on = [aws_lb.lb]
  for_each   = var.lb_listener_authenticate_cognito_map

  load_balancer_arn = aws_lb.lb[0].arn
  alpn_policy       = each.value.alpn_policy == "value" ? null : each.value.alpn_policy
  certificate_arn   = each.value.certificate_arn == "value" ? null : each.value.certificate_arn
  port              = each.value.port == 0 ? null : each.value.port
  protocol          = each.value.protocol == "value" ? null : each.value.protocol
  ssl_policy        = each.value.ssl_policy == "value" ? null : each.value.ssl_policy
  tags              = merge(var.general_tags, var.lb_listener_tags)
  dynamic "mutual_authentication" {
    for_each = each.value.mutual_authentication[0].mode != "value" && each.value.mutual_authentication[0].trust_store_arn != "value" ? [1] : []
    content {
      mode                             = each.value.mutual_authentication[0].mode
      trust_store_arn                  = each.value.mutual_authentication[0].trust_store_arn
      ignore_client_certificate_expiry = each.value.mutual_authentication[0].ignore_client_certificate_expiry
    }
  }
  default_action {
    type  = "authenticate_cognito"
    order = each.value.default_action[0].order == 0 ? null : each.value.default_action[0].order
    dynamic "authenticate_cognito" {
      for_each = ((
        each.value.default_action[0].authenticate_cognito[0].user_pool_arn != "value") && (
        each.value.default_action[0].authenticate_cognito[0].user_pool_client_id != "value") && (
        each.value.default_action[0].authenticate_cognito[0].user_pool_domain != "value"
      )) ? [1] : []
      content {
        user_pool_arn                       = each.value.default_action[0].authenticate_cognito[0].user_pool_arn
        user_pool_client_id                 = each.value.default_action[0].authenticate_cognito[0].user_pool_client_id
        user_pool_domain                    = each.value.default_action[0].authenticate_cognito[0].user_pool_domain
        authentication_request_extra_params = each.value.default_action[0].authenticate_cognito[0].authentication_request_extra_params
        on_unauthenticated_request          = each.value.default_action[0].authenticate_cognito[0].on_unauthenticated_request
        scope                               = each.value.default_action[0].authenticate_cognito[0].scope
        session_cookie_name                 = each.value.default_action[0].authenticate_cognito[0].session_cookie_name
        session_timeout                     = each.value.default_action[0].authenticate_cognito[0].session_timeout
      }
    }
  }
}
