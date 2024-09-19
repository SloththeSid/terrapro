# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "project_id" {
  description = "Project ID"
  default     = "teratask-436014"  # Your project ID
}

variable "region" {
  description = "Region"
  default     = "asia-south1"  # Your region
}

provider "google" {
  project     = var.project_id
  region      = var.region
  # Remove the line below if it exists
  # credentials = file("${path.module}/credentials.json")
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = false  # No need for quotes around false
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

# Optional Outputs (if needed)
output "vpc_name" {
  description = "The name of the VPC"
  value       = google_compute_network.vpc.name
}

output "subnet_name" {
  description = "The name of the Subnet"
  value       = google_compute_subnetwork.subnet.name
}
