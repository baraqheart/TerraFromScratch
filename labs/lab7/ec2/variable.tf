variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string

}

variable "instance_type" {
  description = "the type or size of instance used"
  type = string
}

variable "public_subnet_zone1" {
  description = "availability zone 1 for public subnet"

}