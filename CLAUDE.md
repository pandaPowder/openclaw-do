# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Terraform configuration that provisions an **OpenClaw** instance on DigitalOcean — a single droplet running the OpenClaw marketplace image, configured to authenticate with a Claude Pro subscription via a long-lived OAuth token.

## Common commands

```bash
# One-time setup
cp terraform.tfvars.example terraform.tfvars
# Fill in do_token, claude_oauth_token, and allowed_ssh_cidr in terraform.tfvars

terraform init
terraform plan
terraform apply

# Tear down
terraform destroy

# Check current outputs (IP, SSH command, dashboard URL)
terraform output
```

## Architecture

All infrastructure is defined in three files:

- **`main.tf`** — provider, SSH key upload, droplet, and firewall resources
- **`variables.tf`** — input variables with defaults
- **`outputs.tf`** — droplet IP, dashboard URL, SSH command, and post-provision steps

The droplet uses `user_data` to inject `CLAUDE_CODE_OAUTH_TOKEN` into `/etc/environment` at first boot. The token comes from `claude setup-token` on the local machine.

## Key variables

| Variable | Source | Notes |
|---|---|---|
| `do_token` | DigitalOcean console → API → Personal Access Tokens | Required, sensitive |
| `claude_oauth_token` | Run `claude setup-token` locally | Required, sensitive |
| `allowed_ssh_cidr` | Your current public IP (`/32`) | Required in `terraform.tfvars` (no default) |
| `image_slug` | DigitalOcean marketplace | Verify: `doctl compute image list --public \| grep openclaw` |

## Post-provision

After `terraform apply`, SSH in and run `openclaw onboard`:
- Select: Anthropic → Anthropic Claude CLI (Reuse a local Claude CLI login)
- Authenticate via browser when prompted
- Dashboard: `https://<droplet-ip>`
