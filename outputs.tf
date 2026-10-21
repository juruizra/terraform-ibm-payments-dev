output "public_ip" {
  description = "Public IP address assigned to the VSI"
  value       = ibm_is_floating_ip.payments.address
}

output "ssh_command" {
  description = "SSH command to connect to the VSI"
  value       = "ssh root@${ibm_is_floating_ip.payments.address}"
}
