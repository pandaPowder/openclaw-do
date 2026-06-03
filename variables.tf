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

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to reach port 22. Update when your IP changes."
  type        = string
  default     = "71.195.226.15/32"
}
