variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "credentials" {
  description = "path to my service account key file"
  type        = string
  sensitive   = true
}

variable "ssh_user" {
  description = "Username for SSH access"
  type        = string
  default     = "your-username"
}

variable "ssh_public_key_path" {
  description = "Path to your public SSH key"
  type        = string
  default     = "/home/your-username/.ssh/id_rsa.pub"
}

