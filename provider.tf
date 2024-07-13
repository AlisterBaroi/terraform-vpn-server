terraform{
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "5.18.0"
      }
    }
    backend "gcs" {
      # bucket = "your-gcp-bucket-name"                               # Provide your GCP bucket name, if you save the ".tfstate" statefile on cloud storage instead of saving locally   
      # prefix  = "directory-inside-your-gcp-bucket"                  # Provide the directory within your GCP bucket, if you save the ".tfstate" statefile on cloud storage instead of saving locally
      credentials = "./cred.json"                                     # Create GCP credentials file and put in the main foler, renaming as "cred.json" 
    }
    
}

# Set the project details according to the GCP cloud console
provider "google" {
  project = "your-project-id"                                         # GCP project name
  region  = "your-project-region"                                     # GCP project region
  zone    = "your-project-zone"                                       # GCP project zone
  credentials = "./cred.json"                                         # Service Account Key
}
