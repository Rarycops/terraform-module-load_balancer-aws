# locals {
#   listener_check = try(flatten([
#     for listener in var.lb_listener_map : [
#       for action in listener.default_action : action.type
#     ]
#   ]), ["value"])

#   lb_listener_map = (
#     (var.load_balancer_type == "lb" && var.lb_listener_map != {} && !contains(local.listener_check, "value"))
#   ) ? var.lb_listener_map : {}
# }
