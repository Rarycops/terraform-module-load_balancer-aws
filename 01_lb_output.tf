output "elb_id" {
  description = "The name of the ELB."
  value       = aws_elb.elb.id
}

output "elb_arn" {
  description = "The ARN of the ELB."
  value       = aws_elb.elb.arn
}

output "elb_name" {
  description = "The name of the ELB."
  value       = aws_elb.elb.name
}

output "elb_dns_name" {
  description = "The DNS name of the ELB."
  value       = aws_elb.elb.dns_name
}

output "elb_isntances" {
  description = "The list of instances in the ELB."
  value       = aws_elb.elb.instances
}

output "elb_source_security_group" {
  description = "The name of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Use this for Classic or Default VPC only."
  value       = try(aws_elb.elb.source_security_group, null)
}

output "elb_source_security_group_id" {
  description = "The ID of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Only available on ELBs launched in a VPC."
  value       = try(aws_elb.elb.source_security_group_id, null)
}

output "elb_zone_id" {
  description = "The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)"
  value       = aws_elb.elb.zone_id
}

output "elb_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_elb.elb.tags_all
}

