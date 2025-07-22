# gcp-tf-backend-creator/main.tf

# Google Cloud Provider configuration
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Resource: Google Cloud Storage Bucket for Terraform state files
resource "google_storage_bucket" "terraform_state_bucket" {
  # Bucket name must be globally unique.
  # We construct it using the project ID and a suffix for uniqueness.
  name          = "${var.gcp_project_id}-${var.bucket_name_suffix}"
  location      = var.gcp_region # GCS buckets are regional or multi-regional, not zonal.
  project       = var.gcp_project_id

  # Enable versioning: CRITICAL for state management to recover from accidental deletions
  versioning {
    enabled = true
  }

  # Enable Uniform Bucket-Level Access: Simplifies permissions by disabling object ACLs, recommended.
  uniform_bucket_level_access = true

  # Lifecycle rules (optional but recommended):
  # Configure to delete older versions of objects, keeping a few for recovery.
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      # Keep at least 3 newer versions of the state file.
      num_newer_versions = 3
      # Optional: age = 90 # Uncomment to delete versions older than 90 days.
    }
  }



  # force_destroy: Use with EXTREME CAUTION!
  # If 'true', allows the bucket to be deleted even if it contains objects.
  # Keep 'false' in production to prevent accidental state deletion.
  force_destroy = var.force_destroy_bucket

  # Labels for organizing and filtering resources in GCP
  labels = {
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "tf-state-backend"
  } 
}