# OpenClaw DigitalOcean Droplet (Terraform)
Simple Terraform configuration to provision an OpenClaw droplet on DigitalOcean.
Official OpenClaw documentation: https://docs.openclaw.ai/
DigitalOcean tutorial: https://www.digitalocean.com/community/tutorials/how-to-run-openclaw

## What this provisions
- One DigitalOcean droplet from an OpenClaw marketplace image
- One uploaded SSH key for root access
- One firewall with:
  - SSH limited to your configured CIDR (`allowed_ssh_cidr`)
  - HTTP/HTTPS open to the internet
- Droplet boot-time injection of `CLAUDE_CODE_OAUTH_TOKEN` via `user_data`

## Prerequisites
- Terraform installed
- DigitalOcean account + personal access token
- SSH public key on your machine
- Claude OAuth token from:
  - `claude setup-token`

## Setup
1. Create your local tfvars file:
   - `cp terraform.tfvars.example terraform.tfvars`
2. Edit `terraform.tfvars` and set:
   - `do_token`
   - `claude_oauth_token`
   - `allowed_ssh_cidr` (usually `YOUR_PUBLIC_IP/32`)
3. Initialize and preview:
   - `terraform init`
   - `terraform plan`
4. Apply:
   - `terraform apply`

## Outputs
After apply:
- `terraform output` shows:
  - droplet IP
  - dashboard URL
  - SSH command
  - suggested next steps

## Security notes
- `terraform.tfvars` is gitignored — keep secrets there only.
- Do not hardcode secrets in Terraform source files.
- Restrict `allowed_ssh_cidr` to your current public IP whenever possible.

## License
MIT — see `LICENSE`.
