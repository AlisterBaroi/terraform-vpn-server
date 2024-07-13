terraform{
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "5.18.0"
      }
    }
    backend "gcs" {
      bucket = "readjobs-terraform-statefiles"
      prefix  = "VPN/state"
      credentials = "./cred.json"                                     # Create GCP credentials file and put in the main foler, renaming as "cred.json" 
    }
    
}

# Set the project details according to the GCP cloud console
provider "google" {
  project = "resumeparser-403715" # GCP project name
  region  = "europe-west2" # GCP project region
  zone    = "europe-west2b" # GCP project zone
  credentials = "./cred.json" # Service Account Key
}
