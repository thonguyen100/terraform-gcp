variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}

variable "github_owner" {
  description = "The GitHub username or organization name"
  type        = string
}

variable "gcp_project_region" {
  description = "The GCP project region"
  type = string
}


variable "network_name" {
  description = "Name of the VPC network"
  type = string
}


