locals {
  default_lb_listener_map = {
    "listener" = {
      alpn_policy     = "value"
      certificate_arn = "value"
      default_action = [{
        authenticate_cognito = [{
          authentication_request_extra_params = {
            "name" = "value"
          }
          on_unauthenticated_request = "value"
          scope                      = "value"
          session_cookie_name        = "value"
          session_timeout            = 0
          user_pool_arn              = "value"
          user_pool_client_id        = "value"
          user_pool_domain           = "value"
        }]
        authenticate_oidc = [{
          authentication_request_extra_params = {
            "name" = "value"
          }
          authorization_endpoint     = "value"
          client_id                  = "value"
          client_secret              = "value"
          issuer                     = "value"
          on_unauthenticated_request = "value"
          scope                      = "value"
          session_cookie_name        = "value"
          session_timeout            = 0
          token_endpoint             = "value"
          user_info_endpoint         = "value"
        }]
        fixed_response = [{
          content_type = "value"
          message_body = "value"
          status_code  = "value"
        }]
        forward = [{
          target_group = [{
            arn    = "value"
            weight = 0
          }]
        }]
        order = 0
        redirect = [{
          host        = "value"
          path        = "value"
          port        = "value"
          protocol    = "value"
          query       = "value"
          status_code = "value"
        }]
        target_group_arn = "arn:aws:lambda:us-west-2:123456789012:function:my-function"
        type             = "forward"
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
}

# arn:aws:lambda:us-west-2:123456789012:function:my-function
