locals {
  security_groups_ports = { for sg in setproduct(var.to_sgs, var.ports) : "${sg[0]}/${sg[1]}" => {
    to   = sg[0]
    port = sg[1]
    }
  }
}

resource "aws_security_group_rule" "rule" {
  # go over each rule in a product split values in from and to if it contains "-"
  for_each          = local.security_groups_ports
  type              = "ingress"
  from_port         = replace(each.value.port, "-", "") == each.value.port ? each.value.port : split("-", each.value.port)[0]
  to_port           = replace(each.value.port, "-", "") == each.value.port ? each.value.port : split("-", each.value.port)[1]
  protocol          = var.protocol
  cidr_blocks       = var.from_cidrs
  security_group_id = each.value.to
  description       = var.description
}
