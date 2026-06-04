variable "do_token" {
  description = "DigitalOcean personal access token"
  type        = string
  sensitive   = true
}

variable "image_slug" {
  description = "DigitalOcean marketplace image slug for OpenClaw. Find with: doctl compute image list --public | grep openclaw"
  type        = string
  default     = "openclaw"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key to upload to DigitalOcean"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "claude_oauth_token" {
  description = "Long-lived Claude OAuth token from `claude setup-token`. Used to authenticate OpenClaw with your Claude Pro subscription."
  type        = string
  sensitive   = true
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to reach port 22 (recommended: your current public IP/32)."
  type        = string
}
