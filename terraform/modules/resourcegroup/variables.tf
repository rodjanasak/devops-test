variable "project" {}
variable "location" {}
variable "location_shortcut" {}

variable "tags" {
  description = "A map of tags to set on every taggable resources. Empty by default."
  type        = map(any)
  default     = {}
}