locals {
  security_groups_ports = { for sg in setproduct(var.from, var.to_sgs, var.ports) : "${sg[0].description}/${sg[1]}/${sg[2]}" => {
    from = sg[0]
    to   = sg[1]
    port = sg[2]
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
  ipv6_cidr_blocks  = []
  prefix_list_ids   = []
  cidr_blocks       = each.value.from.cidrs
  security_group_id = each.value.to
  description       = each.value.from.description
}
