resource "google_container_cluster" "tools" {
  name               = "tools"
  initial_node_count = 2
  min_master_version = "1.17.13-gke.2600"
  node_version       = "1.17.13-gke.2600"
  network            = "production"
  subnetwork         = "prod-data"
  node_config {
    tags = ["allow-to-postgres"]
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    machine_type = "custom-2-5120"
    disk_size_gb = 50
    image_type   = "COS"
  }
}
