output "floating_ip" {
  description = "Public IP address of the payments VSI."
  value       = ibm_is_floating_ip.payments.address
}

output "ssh_command" {
  description = "Ready-to-use SSH command to connect to the VSI."
  value       = "ssh root@${ibm_is_floating_ip.payments.address}"
}

output "instance_id" {
  description = "CRN/ID of the VSI instance."
  value       = ibm_is_instance.payments.id
}
