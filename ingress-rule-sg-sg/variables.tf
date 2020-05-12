variable "from_sgs" {
  description = "Source Security Group Ids"
  type        = list(string)
}

variable "to_sgs" {
  description = "Destination Security Group Ids"
  type        = list(string)
}

variable "ports" {
  description = "Port Numbers or Ranges"
  type        = list(string)
}

variable "protocol" {
  description = "Protocol"
  type        = string
  default     = "tcp"
}

variable "description" {
  description = "Description"
  type        = string
  default     = ""
}
