variable "general_tags" {
  description = "General tags provided for the whole module"
  type        = map(string)
  default     = {}
}

variable "load_balancer_type" {
  description = "value"
  type        = string
  validation {
    condition = can(
      regex(
        "^elb|lb$",
        var.load_balancer_type
      )
    )
    error_message = "One of elb (classic) or lb (network, gateway or application)"
  }
}
