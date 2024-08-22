variable "key_name" {
  description = "Name for the key pair"
  type        = string
}

variable "public_key" {
  description = "The public key material to be imported"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
