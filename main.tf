terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = var.token # or `GITHUB_TOKEN`
}

resource "github_repository" "example" {
  name        = "example"
  description = "My awesome codebase"
  auto_init   = true
}

# resource "github_branch" "development" {
#   repository = github_repository.example.name
#   branch     = "development"
# }

# resource "github_branch_default" "default"{
#   repository = github_repository.example.name
#   branch     = github_branch.development.branch
# }

variable "token" {
  description = "GitHub token with repo permissions"
  type        = string
  sensitive   = true
  
}

#GCP-config
provider "google" {
  project     = "my-project-id"
  region      = "us-central1"
    zone = "us-central1-a" # Choose your zone
  /*
  credentials = file("<path-to-your-service-account-key>.json") # Path to your service account key file
  */
}

#Create-GCP-Network
data "google_compute_network" "my-web-server-network" {
  name = "my-web-server-network" # Replace with your network name
  
}
#Create-subnet
resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.custom-test.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_network" "custom-test" {
  name                    = "test-network"
  auto_create_subnetworks = false
}

#Create-firewall-rule
resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
}

resource "google_compute_network" "default" {
  name = "test-network"
}

