output "droplet_ip" {
  description = "Public IP of the OpenClaw Droplet"
  value       = digitalocean_droplet.openclaw.ipv4_address
}

output "dashboard_url" {
  description = "OpenClaw browser dashboard"
  value       = "https://${digitalocean_droplet.openclaw.ipv4_address}"
}

output "ssh_command" {
  description = "SSH into the Droplet"
  value       = "ssh root@${digitalocean_droplet.openclaw.ipv4_address}"
}

output "next_steps" {
  description = "Post-provision setup instructions"
  value       = <<-EOF
    1. SSH in:        ssh root@${digitalocean_droplet.openclaw.ipv4_address}
    2. Run onboarding: openclaw onboard
       - Select: Anthropic → Anthropic Claude CLI (Reuse a local Claude CLI login)
       - Authenticate via browser when prompted
    3. Open dashboard: https://${digitalocean_droplet.openclaw.ipv4_address}
  EOF
}
