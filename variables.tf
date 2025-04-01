variable "ssh_key_name" {
  type        = string
  description = "SSH Keypair name for SSH access"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH Public key for SSH access"
}

variable "vps_instance_type" {
  type        = string
  default     = "t2.medium"
  description = "The VPS instance type"
}

variable "vps_ami" {
  type        = string
  default     = "ami-058bd2d568351da34"
  description = "The VPS AMI"
}

variable "vps_root_block_volume_size" {
  type        = number
  default     = 20
  description = "The amount of storage of the root block device"
}

variable "vps_roles" {
  type        = list(string)
  default     = ["vps"]
  description = "The roles to assign to the VPS"
}

variable "vps_name" {
  type        = string
  default     = "vps"
  description = "The EC2 name for the VPS"
}

variable "vps_count" {
  type        = number
  default     = 1
  description = "The number of VPS to create"
}