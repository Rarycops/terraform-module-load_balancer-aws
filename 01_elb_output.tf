output "elb_id" {
  description = "The name of the ELB."
  value       = try(aws_elb.elb[0].id, null)
}

output "elb_arn" {
  description = "The ARN of the ELB."
  value       = try(aws_elb.elb[0].arn, null)
}

output "elb_name" {
  description = "The name of the ELB."
  value       = try(aws_elb.elb[0].name, null)
}

output "elb_dns_name" {
  description = "The DNS name of the ELB."
  value       = try(aws_elb.elb[0].dns_name, null)
}

output "elb_isntances" {
  description = "The list of instances in the ELB."
  value       = try(aws_elb.elb[0].instances, null)
}

output "elb_source_security_group" {
  description = "The name of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Use this for Classic or Default VPC only."
  value       = try(aws_elb.elb[0].source_security_group, null)
}

output "elb_source_security_group_id" {
  description = "The ID of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Only available on ELBs launched in a VPC."
  value       = try(aws_elb.elb[0].source_security_group_id, null)
}

output "elb_zone_id" {
  description = "The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)"
  value       = try(aws_elb.elb[0].zone_id, null)
}

output "elb_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = try(aws_elb.elb[0].tags_all, null)
}

