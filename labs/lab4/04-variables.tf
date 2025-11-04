

variable "lab" {
  description = "Deploy 2-tier architecture using terraform."
  type        = string
  default     = "lab3"

}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string


}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = list(string)

}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnets"
  type        = list(string)

}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string

}

variable "instance_type" {
  description = "the type or size of instance used"
  type = string
}