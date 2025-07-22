# gcp-tf-backend-creator/variables.tf

variable "gcp_project_id" {
  description = "The GCP project ID where the GCS bucket will be created."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region where the GCS bucket will be located (e.g., us-central1)."
  type        = string
}

variable "bucket_name_suffix" {
  description = "A suffix for the GCS bucket name to ensure global uniqueness (e.g., 'terraform-state')."
  type        = string
  default     = "terraform-state"
}

variable "environment" {
  description = "Environment tag for the GCS bucket (e.g., 'dev', 'prod')."
  type        = string
  default     = "dev"
}

variable "force_destroy_bucket" {
  description = "Set to true to allow the bucket to be destroyed even if it contains objects. Use with EXTREME CAUTION."
  type        = bool
  default     = false
}