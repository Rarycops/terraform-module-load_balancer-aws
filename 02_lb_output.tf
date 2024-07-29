output "lb_arn" {
  description = "ARN of the load balancer"
  value       = try(aws_lb.lb[0].arn, null)
}

output "lb_arn_sufix" {
  description = "ARN suffix for use with CloudWatch Metrics."
  value       = try(aws_lb.lb[0].arn_suffix, null)
}

output "lb_dns_name" {
  description = "DNS name of the load balancer."
  value       = try(aws_lb.lb[0].dns_name, null)
}

output "lb_subnet_mapping_id" {
  description = " ID of the Outpost containing the load balancer."
  value       = try(aws_lb.lb[0].subnet_mapping.*.outpost_id, null)
}

output "lb_tags_all" {
  description = "Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = try(aws_lb.lb[0].tags_all, null)
}

output "lb_zone_id" {
  description = "Canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)."
  value       = try(aws_lb.lb[0].zone_id, null)
}

output "lb_listener" {
  description = "lb_listener object deployed"
  value       = try(aws_lb_listener.lb_listener, null)
}

output "lb_listener_forward" {
  description = "lb_listener_forward object deployed"
  value       = try(aws_lb_listener.lb_listener_forward, null)
}
output "lb_listener_redirect" {
  description = "lb_listener_redirect object deployed"
  value       = try(aws_lb_listener.lb_listener_redirect, null)
}
output "lb_listener_fixed_response" {
  description = "lb_listener_fixed_response object deployed"
  value       = try(aws_lb_listener.lb_listener_fixed_response, null)
}
output "lb_listener_authenticate_oidc" {
  description = "lb_listener_authenticate_oidc object deployed"
  value       = try(aws_lb_listener.lb_listener_authenticate_oidc, null)
}
output "lb_listener_authenticate_cognito" {
  description = "lb_listener_authenticate_cognito object deployed"
  value       = try(aws_lb_listener.lb_listener_authenticate_cognito, null)
}
