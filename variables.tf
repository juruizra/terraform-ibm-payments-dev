variable "name" {
  description = "Base name prefix for all resources."
  type        = string
  default     = "payments-dev"
}

variable "region" {
  description = "IBM Cloud region."
  type        = string
  default     = "us-south"
}

variable "zone" {
  description = "IBM Cloud zone within the region."
  type        = string
  default     = "us-south-1"
}

variable "instance_profile" {
  description = "VSI profile (size)."
  type        = string
  default     = "cx2-2x4"
}

variable "ssh_public_key" {
  description = "RSA public key content to register in IBM Cloud VPC."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to attach to all resources."
  type        = list(string)
  default     = ["team:payments", "env:dev"]
}
