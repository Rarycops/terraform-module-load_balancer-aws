## Requirements

The following requirements are needed by this module:

- <a name="requirement_aws"></a> [aws](#requirement\_aws) (5.59.0)

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (5.59.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [aws_elb.elb](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/elb) (resource)
- [aws_lb.lb](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/lb) (resource)
- [aws_lb_listener.lb_listener](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/lb_listener) (resource)
- [aws_lb_listener.lb_listener_authenticate_cognito](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/lb_listener) (resource)
- [aws_lb_listener.lb_listener_authenticate_oidc](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/lb_listener) (resource)
- [aws_lb_listener.lb_listener_fixed_response](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/lb_listener) (resource)
- [aws_lb_listener.lb_listener_forward](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/lb_listener) (resource)
- [aws_lb_listener.lb_listener_redirect](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/lb_listener) (resource)
- [aws_lb_target_group.lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/lb_target_group) (resource)
- [aws_lb_target_group_attachment.lb_target_group_attachment](https://registry.terraform.io/providers/hashicorp/aws/5.59.0/docs/resources/lb_target_group_attachment) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type)

Description: value

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_elb_access_logs_bucket"></a> [elb\_access\_logs\_bucket](#input\_elb\_access\_logs\_bucket)

Description: The S3 bucket name to store the logs in.

Type: `string`

Default: `null`

### <a name="input_elb_access_logs_bucket_prefix"></a> [elb\_access\_logs\_bucket\_prefix](#input\_elb\_access\_logs\_bucket\_prefix)

Description: The S3 bucket prefix. Logs are stored in the root if not configured.

Type: `string`

Default: `null`

### <a name="input_elb_access_logs_enabled"></a> [elb\_access\_logs\_enabled](#input\_elb\_access\_logs\_enabled)

Description: Boolean to enable / disable access\_logs.

Type: `bool`

Default: `true`

### <a name="input_elb_access_logs_interval"></a> [elb\_access\_logs\_interval](#input\_elb\_access\_logs\_interval)

Description: The publishing interval in minutes. Valid values: 5 and 60.

Type: `number`

Default: `60`

### <a name="input_elb_availability_zones"></a> [elb\_availability\_zones](#input\_elb\_availability\_zones)

Description: (Required for an EC2-classic ELB) The AZ's to serve traffic in.

Type: `list(string)`

Default: `null`

### <a name="input_elb_connection_draining"></a> [elb\_connection\_draining](#input\_elb\_connection\_draining)

Description: Boolean to enable connection draining.

Type: `bool`

Default: `false`

### <a name="input_elb_connection_draining_timeout"></a> [elb\_connection\_draining\_timeout](#input\_elb\_connection\_draining\_timeout)

Description: The time in seconds to allow for connections to drain.

Type: `number`

Default: `300`

### <a name="input_elb_cross_zone_load_balancing"></a> [elb\_cross\_zone\_load\_balancing](#input\_elb\_cross\_zone\_load\_balancing)

Description: Enable cross-zone load balancing.

Type: `bool`

Default: `true`

### <a name="input_elb_desync_mitigation_mode"></a> [elb\_desync\_mitigation\_mode](#input\_elb\_desync\_mitigation\_mode)

Description: Determines how the load balancer handles requests that might pose a security risk to an application due to HTTP desync.

Type: `string`

Default: `"defensive"`

### <a name="input_elb_health_check_healthy_threshold"></a> [elb\_health\_check\_healthy\_threshold](#input\_elb\_health\_check\_healthy\_threshold)

Description: The number of checks before the instance is declared healthy.

Type: `number`

Default: `null`

### <a name="input_elb_health_check_interval"></a> [elb\_health\_check\_interval](#input\_elb\_health\_check\_interval)

Description: The interval between checks.

Type: `number`

Default: `null`

### <a name="input_elb_health_check_target"></a> [elb\_health\_check\_target](#input\_elb\_health\_check\_target)

Description: The target of the check.

Type: `number`

Default: `null`

### <a name="input_elb_health_check_timeout"></a> [elb\_health\_check\_timeout](#input\_elb\_health\_check\_timeout)

Description: The length of time before the check times out.

Type: `number`

Default: `null`

### <a name="input_elb_health_check_unhealthy_threshold"></a> [elb\_health\_check\_unhealthy\_threshold](#input\_elb\_health\_check\_unhealthy\_threshold)

Description: The number of checks before the instance is declared unhealthy.

Type: `number`

Default: `null`

### <a name="input_elb_idle_timeout"></a> [elb\_idle\_timeout](#input\_elb\_idle\_timeout)

Description: The time in seconds that the connection is allowed to be idle.

Type: `number`

Default: `60`

### <a name="input_elb_internal"></a> [elb\_internal](#input\_elb\_internal)

Description: If true, ELB will be an internal ELB.

Type: `bool`

Default: `false`

### <a name="input_elb_istances"></a> [elb\_istances](#input\_elb\_istances)

Description: A list of instance ids to place in the ELB pool.

Type: `list(string)`

Default: `null`

### <a name="input_elb_listener_map"></a> [elb\_listener\_map](#input\_elb\_listener\_map)

Description: A list of listener blocks.

Type:

```hcl
map(object({
    instance_port     = number
    instance_protocol = string
    lb_port           = number
    lb_protocol       = string
  }))
```

Default: `null`

### <a name="input_elb_name"></a> [elb\_name](#input\_elb\_name)

Description: The name of the ELB. By default generated by Terraform.

Type: `string`

Default: `null`

### <a name="input_elb_security_groups"></a> [elb\_security\_groups](#input\_elb\_security\_groups)

Description: A list of security group IDs to assign to the ELB.

Type: `list(string)`

Default: `null`

### <a name="input_elb_subnets"></a> [elb\_subnets](#input\_elb\_subnets)

Description: (Required for a VPC ELB) A list of subnet IDs to attach to the ELB. When an update to subnets will remove all current subnets, this will force a new resource.

Type: `list(string)`

Default: `null`

### <a name="input_elb_tags"></a> [elb\_tags](#input\_elb\_tags)

Description: ELB tags provided

Type: `map(string)`

Default: `{}`

### <a name="input_general_tags"></a> [general\_tags](#input\_general\_tags)

Description: General tags provided for the whole module

Type: `map(string)`

Default: `{}`

### <a name="input_lb_access_logs_bucket"></a> [lb\_access\_logs\_bucket](#input\_lb\_access\_logs\_bucket)

Description: The S3 bucket name to store the logs in.

Type: `string`

Default: `null`

### <a name="input_lb_access_logs_enabled"></a> [lb\_access\_logs\_enabled](#input\_lb\_access\_logs\_enabled)

Description: Boolean to enable / disable access\_logs.

Type: `bool`

Default: `false`

### <a name="input_lb_access_logs_prefix"></a> [lb\_access\_logs\_prefix](#input\_lb\_access\_logs\_prefix)

Description: The S3 bucket prefix. Logs are stored in the root if not configured.

Type: `string`

Default: `null`

### <a name="input_lb_client_keep_alive"></a> [lb\_client\_keep\_alive](#input\_lb\_client\_keep\_alive)

Description: Client keep alive value in seconds. The valid range is 60-604800 seconds. The default is 3600 seconds.

Type: `number`

Default: `3600`

### <a name="input_lb_connection_logs_bucket"></a> [lb\_connection\_logs\_bucket](#input\_lb\_connection\_logs\_bucket)

Description: The S3 bucket name to store the logs in.

Type: `string`

Default: `null`

### <a name="input_lb_connection_logs_enabled"></a> [lb\_connection\_logs\_enabled](#input\_lb\_connection\_logs\_enabled)

Description: Boolean to enable / disable connection\_logs.

Type: `bool`

Default: `false`

### <a name="input_lb_connection_logs_prefix"></a> [lb\_connection\_logs\_prefix](#input\_lb\_connection\_logs\_prefix)

Description: The S3 bucket prefix. Logs are stored in the root if not configured.

Type: `string`

Default: `null`

### <a name="input_lb_customer_owned_ipv4_pool"></a> [lb\_customer\_owned\_ipv4\_pool](#input\_lb\_customer\_owned\_ipv4\_pool)

Description: ID of the customer owned ipv4 pool to use for this load balancer.

Type: `string`

Default: `null`

### <a name="input_lb_desync_mitigation_mode"></a> [lb\_desync\_mitigation\_mode](#input\_lb\_desync\_mitigation\_mode)

Description: How the load balancer handles requests that might pose a security risk to an application due to HTTP desync. Valid values are monitor, defensive (default), strictest.

Type: `string`

Default: `"defensive"`

### <a name="input_lb_dns_record_client_routing_policy"></a> [lb\_dns\_record\_client\_routing\_policy](#input\_lb\_dns\_record\_client\_routing\_policy)

Description: How traffic is distributed among the load balancer Availability Zones.

Type: `string`

Default: `null`

### <a name="input_lb_drop_invalid_header_fields"></a> [lb\_drop\_invalid\_header\_fields](#input\_lb\_drop\_invalid\_header\_fields)

Description: Whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). Only valid for Load Balancers of type application.

Type: `bool`

Default: `false`

### <a name="input_lb_enable_cross_zone_load_balancing"></a> [lb\_enable\_cross\_zone\_load\_balancing](#input\_lb\_enable\_cross\_zone\_load\_balancing)

Description: If true, cross-zone load balancing of the load balancer will be enabled. For application load balancer this feature is always enabled (true) and cannot be disabled.

Type: `bool`

Default: `false`

### <a name="input_lb_enable_deletion_protection"></a> [lb\_enable\_deletion\_protection](#input\_lb\_enable\_deletion\_protection)

Description: If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer.

Type: `bool`

Default: `false`

### <a name="input_lb_enable_http2"></a> [lb\_enable\_http2](#input\_lb\_enable\_http2)

Description: Whether HTTP/2 is enabled in application load balancers.

Type: `bool`

Default: `true`

### <a name="input_lb_enable_tls_version_and_cipher_suite_headers"></a> [lb\_enable\_tls\_version\_and\_cipher\_suite\_headers](#input\_lb\_enable\_tls\_version\_and\_cipher\_suite\_headers)

Description: Whether the two headers (x-amzn-tls-version and x-amzn-tls-cipher-suite), which contain information about the negotiated TLS version and cipher suite, are added to the client request before sending it to the target.

Type: `bool`

Default: `false`

### <a name="input_lb_enable_waf_fail_open"></a> [lb\_enable\_waf\_fail\_open](#input\_lb\_enable\_waf\_fail\_open)

Description: Whether to allow a WAF-enabled load balancer to route requests to targets if it is unable to forward the request to AWS WAF.

Type: `bool`

Default: `false`

### <a name="input_lb_enable_xff_client_port"></a> [lb\_enable\_xff\_client\_port](#input\_lb\_enable\_xff\_client\_port)

Description: Whether the X-Forwarded-For header should preserve the source port that the client used to connect to the load balancer in application load balancers.

Type: `bool`

Default: `false`

### <a name="input_lb_enforce_security_group_inbound_rules_on_private_link_traffic"></a> [lb\_enforce\_security\_group\_inbound\_rules\_on\_private\_link\_traffic](#input\_lb\_enforce\_security\_group\_inbound\_rules\_on\_private\_link\_traffic)

Description: Whether inbound security group rules are enforced for traffic originating from a PrivateLink. Only valid for Load Balancers of type network.

Type: `string`

Default: `null`

### <a name="input_lb_idle_timeout"></a> [lb\_idle\_timeout](#input\_lb\_idle\_timeout)

Description: Time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application.

Type: `number`

Default: `60`

### <a name="input_lb_internal"></a> [lb\_internal](#input\_lb\_internal)

Description: If true, the LB will be internal.

Type: `bool`

Default: `false`

### <a name="input_lb_ip_address_type"></a> [lb\_ip\_address\_type](#input\_lb\_ip\_address\_type)

Description: Type of IP addresses used by the subnets for your load balancer.

Type: `string`

Default: `null`

### <a name="input_lb_listener_authenticate_cognito_map"></a> [lb\_listener\_authenticate\_cognito\_map](#input\_lb\_listener\_authenticate\_cognito\_map)

Description: Map for the listener variables for authenticate cognito listeners. This is a way to make listeners maps more manageable. If the variable is not use keep the default

Type:

```hcl
map(object({
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
```

Default: `{}`

### <a name="input_lb_listener_authenticate_oidc_map"></a> [lb\_listener\_authenticate\_oidc\_map](#input\_lb\_listener\_authenticate\_oidc\_map)

Description: Map for the listener variables for authenticate oicd listeners. This is a way to make listeners maps more manageable. If the variable is not use keep the default

Type:

```hcl
map(object({
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
```

Default: `{}`

### <a name="input_lb_listener_fixed_response_map"></a> [lb\_listener\_fixed\_response\_map](#input\_lb\_listener\_fixed\_response\_map)

Description: Map for the listener variables for fixed response listeners. This is a way to make listeners maps more manageable. If the variable is not use keep the default

Type:

```hcl
map(object({
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
```

Default: `{}`

### <a name="input_lb_listener_forward_map"></a> [lb\_listener\_forward\_map](#input\_lb\_listener\_forward\_map)

Description: Map for the listener variables for fordward listeners. This is a way to make listeners maps more manageable. If the variable is not use keep the default

Type:

```hcl
map(object({
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
```

Default: `{}`

### <a name="input_lb_listener_map"></a> [lb\_listener\_map](#input\_lb\_listener\_map)

Description: Map for the listener variables. If the variable is not use keep the default

Type:

```hcl
map(object({
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
```

Default: `{}`

### <a name="input_lb_listener_redirect_map"></a> [lb\_listener\_redirect\_map](#input\_lb\_listener\_redirect\_map)

Description: Map for the listener variables for redirect listeners. This is a way to make listeners maps more manageable. If the variable is not use keep the default

Type:

```hcl
map(object({
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
```

Default: `{}`

### <a name="input_lb_listener_tags"></a> [lb\_listener\_tags](#input\_lb\_listener\_tags)

Description: A map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level.

Type: `map(string)`

Default: `{}`

### <a name="input_lb_load_balancer_type"></a> [lb\_load\_balancer\_type](#input\_lb\_load\_balancer\_type)

Description: Type of load balancer to create. Possible values are application, gateway, or network. The default value is application.

Type: `string`

Default: `"application"`

### <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name)

Description: Name of the LB.

Type: `string`

Default: `null`

### <a name="input_lb_preserve_host_header"></a> [lb\_preserve\_host\_header](#input\_lb\_preserve\_host\_header)

Description: Whether the Application Load Balancer should preserve the Host header in the HTTP request and send it to the target without any change.

Type: `bool`

Default: `false`

### <a name="input_lb_security_groups"></a> [lb\_security\_groups](#input\_lb\_security\_groups)

Description: List of security group IDs to assign to the LB.

Type: `list(string)`

Default: `null`

### <a name="input_lb_subnet_mapping"></a> [lb\_subnet\_mapping](#input\_lb\_subnet\_mapping)

Description: Subnet mapping block.

Type:

```hcl
map(object({
    subnet_id            = string
    allocation_id        = string
    ipv6_address         = string
    private_ipv4_address = string
  }))
```

Default: `null`

### <a name="input_lb_subnets"></a> [lb\_subnets](#input\_lb\_subnets)

Description: List of subnet IDs to attach to the LB.

Type: `list(string)`

Default: `null`

### <a name="input_lb_tags"></a> [lb\_tags](#input\_lb\_tags)

Description: Map of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level.

Type: `map(string)`

Default: `{}`

### <a name="input_lb_target_group_map"></a> [lb\_target\_group\_map](#input\_lb\_target\_group\_map)

Description: Map for the lb target group. default value is the same as null.

Type:

```hcl
map(object({
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
```

Default: `{}`

### <a name="input_lb_target_group_tags"></a> [lb\_target\_group\_tags](#input\_lb\_target\_group\_tags)

Description: Tags for the lb target group

Type: `map(string)`

Default: `{}`

### <a name="input_lb_xff_header_processing_mode"></a> [lb\_xff\_header\_processing\_mode](#input\_lb\_xff\_header\_processing\_mode)

Description: Determines how the load balancer modifies the X-Forwarded-For header in the HTTP request before sending the request to the target.

Type: `string`

Default: `"append"`

## Outputs

The following outputs are exported:

### <a name="output_elb_arn"></a> [elb\_arn](#output\_elb\_arn)

Description: The ARN of the ELB.

### <a name="output_elb_dns_name"></a> [elb\_dns\_name](#output\_elb\_dns\_name)

Description: The DNS name of the ELB.

### <a name="output_elb_id"></a> [elb\_id](#output\_elb\_id)

Description: The name of the ELB.

### <a name="output_elb_isntances"></a> [elb\_isntances](#output\_elb\_isntances)

Description: The list of instances in the ELB.

### <a name="output_elb_name"></a> [elb\_name](#output\_elb\_name)

Description: The name of the ELB.

### <a name="output_elb_source_security_group"></a> [elb\_source\_security\_group](#output\_elb\_source\_security\_group)

Description: The name of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Use this for Classic or Default VPC only.

### <a name="output_elb_source_security_group_id"></a> [elb\_source\_security\_group\_id](#output\_elb\_source\_security\_group\_id)

Description: The ID of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Only available on ELBs launched in a VPC.

### <a name="output_elb_tags_all"></a> [elb\_tags\_all](#output\_elb\_tags\_all)

Description: A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block.

### <a name="output_elb_zone_id"></a> [elb\_zone\_id](#output\_elb\_zone\_id)

Description: The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)

### <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn)

Description: ARN of the load balancer

### <a name="output_lb_arn_sufix"></a> [lb\_arn\_sufix](#output\_lb\_arn\_sufix)

Description: ARN suffix for use with CloudWatch Metrics.

### <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name)

Description: DNS name of the load balancer.

### <a name="output_lb_listener"></a> [lb\_listener](#output\_lb\_listener)

Description: lb\_listener object deployed

### <a name="output_lb_listener_authenticate_cognito"></a> [lb\_listener\_authenticate\_cognito](#output\_lb\_listener\_authenticate\_cognito)

Description: lb\_listener\_authenticate\_cognito object deployed

### <a name="output_lb_listener_authenticate_oidc"></a> [lb\_listener\_authenticate\_oidc](#output\_lb\_listener\_authenticate\_oidc)

Description: lb\_listener\_authenticate\_oidc object deployed

### <a name="output_lb_listener_fixed_response"></a> [lb\_listener\_fixed\_response](#output\_lb\_listener\_fixed\_response)

Description: lb\_listener\_fixed\_response object deployed

### <a name="output_lb_listener_forward"></a> [lb\_listener\_forward](#output\_lb\_listener\_forward)

Description: lb\_listener\_forward object deployed

### <a name="output_lb_listener_redirect"></a> [lb\_listener\_redirect](#output\_lb\_listener\_redirect)

Description: lb\_listener\_redirect object deployed

### <a name="output_lb_subnet_mapping_id"></a> [lb\_subnet\_mapping\_id](#output\_lb\_subnet\_mapping\_id)

Description:  ID of the Outpost containing the load balancer.

### <a name="output_lb_tags_all"></a> [lb\_tags\_all](#output\_lb\_tags\_all)

Description: Map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block.

### <a name="output_lb_target_group"></a> [lb\_target\_group](#output\_lb\_target\_group)

Description: lb\_target\_group object deployed

### <a name="output_lb_zone_id"></a> [lb\_zone\_id](#output\_lb\_zone\_id)

Description: Canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record).
