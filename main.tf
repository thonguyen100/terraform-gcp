terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  token = var.token # or `GITHUB_TOKEN`
}

resource "github_repository" "example" {
  name        = "gcp-web-server"
  description = "My awesome codebase"

  visibility = "public"

  
}

variable "token" {
  description = "GitHub token with repo permissions"
  type        = string
  sensitive   = true
  
}

#GCP-config
provider "google" {
  project     = "my-project-id"
  region      = "us-central1"
}