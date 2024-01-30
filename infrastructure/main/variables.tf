variable "environment" {
  type        = string
  description = "The environment name"
}

variable "location" {
  type        = string
  description = "The location of the resources"
}

variable "tags" {
  type        = map(string)
  description = "The tags to apply to the resources"
}
