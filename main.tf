terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "openclaw" {
  name       = "openclaw-key"
  public_key = file(var.ssh_public_key_path)
}

resource "digitalocean_droplet" "openclaw" {
  name     = "openclaw-prod"
  region   = "sfo3"
  size     = "s-2vcpu-4gb"
  image    = var.image_slug

  ssh_keys = [digitalocean_ssh_key.openclaw.fingerprint]

}

resource "digitalocean_firewall" "openclaw" {
  name        = "openclaw-firewall"
  droplet_ids = [digitalocean_droplet.openclaw.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = [var.allowed_ssh_cidr]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
