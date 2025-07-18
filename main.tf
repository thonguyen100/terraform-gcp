terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}
#GCP-config
provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone 
  
  credentials = file(var.credentials) # Path to your service account key file
  
}

#Create-GCP-Network
resource "google_compute_network" "custom-test" {
  name                    = "test-network"
  auto_create_subnetworks = false
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

#Create-firewall-rule
resource "google_compute_firewall" "custom-test" {
  name    = "test-firewall"
  network = google_compute_network.custom-test.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
}

resource "google_compute_instance" "my-vm" {
  name         = "my-vm-instance"
  machine_type = "e2-micro" # Choose your machine type
  zone         = "us-central1-a" # Choose your zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # Replace with your desired image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.network-with-private-secondary-ip-ranges.name
    access_config {
      nat_ip = google_compute_address.my-vm.address # Assign a static IP address
    }
  }

  metadata = {
    ssh-keys = "your-username:${file("~/.ssh/id_rsa.pub")}" # Replace with your SSH key path
  }
  tags = ["web"] # Tags for the instance, can be used in firewall rules
}

resource "google_compute_address" "my-vm" {
  name         = "my-vm-ip"
  region       = "us-central1" # Choose your region
  address_type = "EXTERNAL" # Use EXTERNAL for public IP, INTERNAL for private IP
  
}
