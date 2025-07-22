# gcp-tf-backend-creator/outputs.tf

output "gcs_backend_bucket_name" {
  description = "The actual name of the created GCS bucket for Terraform state."
  value       = google_storage_bucket.terraform_state_bucket.name
}

output "gcs_backend_bucket_self_link" {
  description = "The self_link of the created GCS bucket."
  value       = google_storage_bucket.terraform_state_bucket.self_link
}