variable "region" {
  description = "IBM Cloud region"
  type        = string
  default     = "us-south"
}

variable "zone" {
  description = "IBM Cloud zone"
  type        = string
  default     = "us-south-1"
}

variable "name" {
  description = "Base name for all resources"
  type        = string
  default     = "payments"
}

variable "profile" {
  description = "VSI instance profile"
  type        = string
  default     = "bx2-2x8"
}

variable "ssh_public_key" {
  description = "Public SSH key content to inject into the VSI"
  type        = string
  sensitive   = true
}
