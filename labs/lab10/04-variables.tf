

variable "lab" {
  description = "Deploy 2-tier architecture using terraform."
  type        = string
  default     = "lab3"

}

// vpc variables

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


// ecs variables
variable "cluster_name" {
  description = "the name od the cluster"
  type        = string
}
variable "service1" {
  description = "name of service 1 "
  type        = string

}
variable "container_port" {
  description = "The port the container is running on"
  type        = string

}

